package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.ClientPreferences;
import com.estgames.estgames_framework.common.GameAgent;
import com.estgames.estgames_framework.core.AndroidUtils;
import com.estgames.estgames_framework.core.EGException;
import com.estgames.estgames_framework.core.Fail;
import com.estgames.estgames_framework.core.Result;
import com.estgames.estgames_framework.core.session.SessionManager;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import kotlin.Unit;
import kotlin.jvm.functions.Function1;

public class UserAllDialog extends Dialog{
    private DialogState STATE_READY;
    private DialogState STATE_SYNC;
    private DialogState STATE_SWITCH;

    private DialogState state;

    private SessionManager sessionManager;
    private ClientPreferences preferences;

    private String identityId;
    private String provider;
    private String egId;
    private Map<String, String> syncData;

    private CompleteHandler completeHandler;
    private CancelHandler cancelHandler;
    private FailHandler failHandler;

    private Future<String> gameuser;

    public UserAllDialog(@NonNull Context context,
                          @NonNull ClientPreferences pref) {
        super(context);
        this.preferences = pref;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.userall);

        sessionManager = new SessionManager(this.getContext());

        STATE_READY = new Ready(this);
        STATE_SYNC = new Sync(this);
        STATE_SWITCH = new Switch(this);

        this.setOnDismissListener(new OnDismissListener() {
            @Override public void onDismiss(DialogInterface dialogInterface) {
                state.dismiss();
            }
        });

        ExecutorService executor = Executors.newSingleThreadExecutor();
        this.gameuser = executor.submit(new Callable<String>() {
            @Override
            public String call() throws Exception {
                return new GameAgent(UserAllDialog.this.getContext()).retrieveGameUser(egId);
            }
        });
        executor.shutdown();
    }

    public void setEgId(@NonNull String egId) {
        this.egId = egId;
    }

    public void setProvider(@NonNull String provider) {
        this.provider = provider;
    }

    public void setIdentityId(@NonNull String id) {
        this.identityId = id;
    }

    public void setData(@NonNull Map<String, String> data) {
        this.syncData = data;
    }

    public UserAllDialog setOnCompleted(CompleteHandler handler) {
        this.completeHandler = handler;
        return this;
    }

    public UserAllDialog setOnCancel(CancelHandler handler) {
        this.cancelHandler = handler;
        return this;
    }

    public UserAllDialog setOnFail(FailHandler handler) {
        this.failHandler = handler;
        return this;
    }

    @Override
    protected void onStart() {
        super.onStart();
        changeState(STATE_READY);
    }

    private String getText(int resourceId) {
        CharSequence text = AndroidUtils.getLocaleText(resourceId, preferences.getLocale(), getContext());
        return text.toString();
    }

    /**
     * Listener Interface
     */
    public interface CompleteHandler { void apply(Result.Login result); }
    public interface CancelHandler { void cancel(); }
    public interface FailHandler { void fail(EGException t); }

    private void changeState(DialogState state) {
        if (this.state != null) {
            this.state.hide();
        }
        this.state = state;
        this.state.show();
    }

    private String getGameuser() {
        try {
            return gameuser.get();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error!!";
        }
    }

    /**
     * Dialog 상태 인터페이스 정의
     */
    private interface DialogState {
        void show();
        void hide();
        void dismiss();
    }

    /**
     * 최초로 보이는 Dialog 창의 상태를 표현.
     * 사용자에게 기존 계정 로그인 또는 현재계정의 연동 선택 화면을 보여줌.
     */
    private class Ready implements DialogState {
        private UserAllDialog context;

        private Ready(UserAllDialog ctx) {
            context = ctx;

            ((TextView)context.findViewById(R.id.txt_ready_title)).setText(
                    context.getText(R.string.estcommon_userLink_title)
            );

            // 기존계정으로 로그인 하기 버튼에 대한 핸들러 등록
            Button btnSwitch = context.findViewById(R.id.btn_switch);
            btnSwitch.setText(context.getText(R.string.estcommon_userLink_confirm));
            btnSwitch.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    context.changeState(context.STATE_SWITCH);
                }
            });

            // 현재 계정에 연동하기 버튼에 대한 핸들러 등록
            Button btnSync = context.findViewById(R.id.btn_sync);
            btnSync.setText(context.getText(R.string.estcommon_userLink_cancel));
            btnSync.setOnClickListener(new View.OnClickListener(){
                @Override public void onClick(View view) {
                    context.changeState(context.STATE_SYNC);
                }
            });

            // 창 닫기 버튼에 대한 핸들러 등록
            context.findViewById(R.id.btn_ready_close).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    context.dismiss();
                }
            });
        }

        @Override public void show() {
            context.findViewById(R.id.v_ready_dialog).setVisibility(View.VISIBLE);
            ((TextView)context.findViewById(R.id.txt_ready_target_data)).setText(
                    String.format(context.getText(R.string.estcommon_userLink_middelLabel), context.provider, context.getGameuser())
            );
            ((TextView)context.findViewById(R.id.txt_ready_current_data)).setText(
                    context.getText(R.string.estcommon_userLink_bottomLabel)
            );
        }

        @Override
        public void hide() {
            context.findViewById(R.id.v_ready_dialog).setVisibility(View.INVISIBLE);
        }

        @Override public void dismiss() {
            context.cancelHandler.cancel();
        }
    }

    /**
     * 계정 불러오기 동의 Dialog 상태의 표현.
     * 사용자에게 기존 계정을 불러올 것인지 의사를 확인하는 화면을 보여줌.
     */
    private class Switch implements DialogState {
        private UserAllDialog context;
        private EditText edConfirm;

        private Switch(UserAllDialog ctx) {
            context = ctx;
            edConfirm = context.findViewById(R.id.ed_switch_confirm_word);
            edConfirm.setHint(context.getText(R.string.estcommon_userLoad_input));

            // 계정 불러오기 동의 버튼에 대한 핸들러 등록
            Button btnConfirm = context.findViewById(R.id.btn_switch_confirm);
            btnConfirm.setText(context.getText(R.string.estcommon_userLoad_confirmButton));
            btnConfirm.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if ("confirm".equals(edConfirm.getText().toString().trim())) {
                        context.sessionManager
                                .create(context.identityId)
                                .right(new Function1<String, Unit>() {
                                    @Override public Unit invoke(String token) {
                                        Result.Login data = new Result.Login(
                                                "SWITCH",
                                                sessionManager.getProfile().getEgId(),
                                                context.provider);

                                        context.changeState(new Complete(context, data));
                                        return null;
                                    }
                                })
                                .left(new Function1<Throwable, Unit>() {
                                    @Override
                                    public Unit invoke(Throwable t) {
                                        context.changeState(new Failure(context, t));
                                        return null;
                                    }
                                });
                    } else {
                        edConfirm.setText("");
                        edConfirm.setHint(context.getText(R.string.estcommon_userLoad_input_wrong));
                    }
                }
            });

            // 창 닫기 버튼에 대한 핸들러 등록
            context.findViewById(R.id.btn_switch_close).setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    context.dismiss();
                }
            });
        }

        @Override public void show() {
            context.findViewById(R.id.v_switch_dialog).setVisibility(View.VISIBLE);
            ((TextView)context.findViewById(R.id.txt_switch_title)).setText(
                    context.getText(R.string.estcommon_userLoad_title)
            );
            ((TextView)context.findViewById(R.id.txt_switch_confirm_desc)).setText(
                    context.getText(R.string.estcommon_userLoad_content)
            );
            ((TextView)context.findViewById(R.id.txt_switch_confirm_word)).setText(
                    context.getText(R.string.estcommon_userLoad_confirmText)
            );
        }

        @Override public void hide() {
            context.findViewById(R.id.v_switch_dialog).setVisibility(View.INVISIBLE);
        }

        @Override public void dismiss() {
            context.cancelHandler.cancel();
        }
    }

    /**
     * 계정연계 동의 Dialog 창 상태의 표현.
     * 사용자에게 현재 플레이 계정과 기존 계정을 연계하고 기존 계정정보는 삭제할지 여부를 묻는 화면을 보여줌.
     */
    private class Sync implements DialogState {
        private UserAllDialog context;

        private Sync(UserAllDialog ctx) {
            context = ctx;

            // 계정 전환 버튼에 대한 핸들러 등록
            Button btnConfirm = context.findViewById(R.id.btn_sync_confirm);
            btnConfirm.setText(context.getText(R.string.estcommon_userGuest_loginBt));
            btnConfirm.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    context.sessionManager
                            .sync(syncData, context.identityId, true)
                            .right(new Function1<Result.SyncComplete, Unit>() {
                                @Override
                                public Unit invoke(Result.SyncComplete result) {
                                    Result.Login data = new Result.Login("SYNC", result.getEgId(), context.provider);
                                    context.changeState(new Complete( context, data));
                                    return null;
                                }
                            })
                            .left(new Function1<Result, Unit>() {
                                @Override
                                public Unit invoke(Result result) {
                                    context.changeState(new Failure(context, ((Result.Failure)result).getCause()));
                                    return null;
                                }
                            });
                }
            });

            // 이전으로 돌아기기 버튼에 대한 핸들러 등록
            Button btnCancel = context.findViewById(R.id.btn_sync_cancel);
            btnCancel.setText(context.getText(R.string.estcommon_userGuest_beforeBt));
            btnCancel.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    context.changeState(context.STATE_READY);
                }
            });

            // 창 닫기 버튼에 대한 핸들러 등록
            context.findViewById(R.id.btn_sync_close).setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View view) {
                    context.dismiss();
                }
            });
        }

        @Override public void show() {
            context.findViewById(R.id.v_sync_dialog).setVisibility(View.VISIBLE);
            ((TextView)context.findViewById(R.id.txt_sync_title)).setText(
                    getText(R.string.estcommon_userGuest_title)
            );
            ((TextView)context.findViewById(R.id.txt_sync_description)).setText(
                    String.format(context.getText(R.string.estcommon_userGuest_middle), context.getGameuser())
            );
        }

        @Override public void hide() {
            context.findViewById(R.id.v_sync_dialog).setVisibility(View.INVISIBLE);
        }

        @Override public void dismiss() {
            context.cancelHandler.cancel();
        }
    }

    /**
     * 사용자 동의 완료 Dialog 창의 상태를 표현.
     * 사용자 전환 또는 동기화 완료가 되었음을 알려주는 화면을 보여줌.
     */
    private class Complete implements DialogState {
        private UserAllDialog context;
        private Result.Login result;

        private Complete(UserAllDialog ctx, Result.Login data) {
            context = ctx;
            result = data;

            // 확인 버튼에 대한 핸들러 등록
            Button btnConfirm = context.findViewById(R.id.btn_complete_confirm);
            btnConfirm.setText(context.getText(R.string.estcommon_userResult_confirm));
            btnConfirm.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    context.dismiss();
                }
            });

            // 창닫기 버튼에 대한 핸들러 등록
            context.findViewById(R.id.btn_complete_close).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    context.dismiss();
                }
            });
        }

        @Override public void show() {
            context.findViewById(R.id.v_complete_dialog).setVisibility(View.VISIBLE);
            ((TextView)context.findViewById(R.id.txt_complete_title)).setText(
                    context.getText(R.string.estcommon_userResult_title)
            );
            ((TextView)context.findViewById(R.id.txt_complete_subtitle)).setText(
                    context.getText(R.string.estcommon_userResult_subTitle)
            );
            ((TextView)context.findViewById(R.id.txt_complete_message)).setText(
                    context.getText(R.string.estcommon_userResult_titleMove)
            );
        }

        @Override public void hide() {
            context.findViewById(R.id.v_complete_dialog).setVisibility(View.INVISIBLE);
        }

        @Override public void dismiss() {
            context.completeHandler.apply(result);
        }
    }

    /**
     * 사용자 계정 전환 또는 동기화가 실패한 상태를 표현.
     * 사용자 동의 Dialog 창을 닫는다.
     */
    private class Failure implements DialogState {
        private UserAllDialog context;
        private Throwable cause;

        private Failure(UserAllDialog ctx, Throwable t) {
            context = ctx;
            cause = t;
        }

        @Override
        public void show() {
            context.dismiss();
        }

        @Override
        public void hide() {
            context.dismiss();
        }

        @Override
        public void dismiss() {
            if (cause instanceof EGException) {
                context.failHandler.fail((EGException) cause);
            } else {
                context.failHandler.fail(Fail.SIGN_SWITCH_OR_SYNC.with(cause.getMessage(), cause));
            }
        }
    }
}
