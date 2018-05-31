package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.CustomFunction;
import com.estgames.estgames_framework.common.CustormSupplier;

public class UserAllDialog extends Dialog{
    RelativeLayout link;
    RelativeLayout load;
    RelativeLayout guest;
    RelativeLayout result;

    Button linkConfirm;
    Button linkCancel;
    Button linkClose;
    private TextView linkSnsDataText;
    private TextView linkGuestDataText;

    Button loadConfirm;
    Button loadClose;
    EditText loadEditText;
    TextView loadText;

    Button guestLogin;
    Button guestBefore;
    Button guestcClose;
    TextView guestText;

    Button resultConfirm;
    Button resultClose;

    int height1;
    int height2;

    public UserAllDialog(@NonNull Context context) {
        super(context);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.userall);

        link = (RelativeLayout) findViewById(R.id.linkDialog);
        load = (RelativeLayout) findViewById(R.id.loadDialog);
        guest = (RelativeLayout) findViewById(R.id.GuestDialog);
        result = (RelativeLayout) findViewById(R.id.ResultDialog);

        linkConfirm = (Button) findViewById(R.id.LinkConfirm);
        linkCancel = (Button) findViewById(R.id.LinkCancel);
        linkClose = (Button) findViewById(R.id.LinkCloseBt);

        loadConfirm = (Button) findViewById(R.id.LoadConfirmBt);
        loadClose = (Button) findViewById(R.id.LoadCloseBt);

        guestLogin = (Button) findViewById(R.id.GuestLinkLoginBt);
        guestBefore = (Button) findViewById(R.id.GuestLinkBeforeBt);
        guestcClose = (Button) findViewById(R.id.GuestLinkCloseBt);

        resultConfirm = (Button) findViewById(R.id.ResultSubmit);
        resultClose = (Button) findViewById(R.id.ResultClose);

        linkSnsDataText = (TextView) findViewById(R.id.LinkSnsDataText);
        linkGuestDataText = (TextView) findViewById(R.id.LinkGuestDataText);

        loadText = (TextView) findViewById(R.id.LoadText);

        guestText = (TextView) findViewById(R.id.GuestLinkMiddleText);

        loadEditText = (EditText) findViewById(R.id.LoadEditText);

//        WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
//        lp.copyFrom(getWindow().getAttributes());
//
//        Window window = getWindow();
//        lp.height = height1;
//        window.setAttributes(lp);


        View.OnClickListener closeListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                link.setVisibility(View.VISIBLE);
                load.setVisibility(View.INVISIBLE);
                guest.setVisibility(View.INVISIBLE);
                result.setVisibility(View.INVISIBLE);
                dismiss();
                closeCallBack.run();
            }
        };

        linkConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                link.setVisibility(View.INVISIBLE);
                load.setVisibility(View.VISIBLE);
            }
        });

        linkCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                link.setVisibility(View.INVISIBLE);
                guest.setVisibility(View.VISIBLE);
            }
        });



        loadConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (confirmCheck.apply(loadEditText.getText().toString())) {
                    load.setVisibility(View.INVISIBLE);
                    result.setVisibility(View.VISIBLE);
                    loadConfirmCallBack.run();
                } else {
                    //failConfirmCheck.run();
                }
            }
        });

        guestLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                guest.setVisibility(View.INVISIBLE);
                result.setVisibility(View.VISIBLE);
                guestConfirmCallBack.run();
            }
        });

        guestBefore.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                guest.setVisibility(View.INVISIBLE);
                link.setVisibility(View.VISIBLE);
            }
        });

        resultConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                link.setVisibility(View.VISIBLE);
                load.setVisibility(View.INVISIBLE);
                guest.setVisibility(View.INVISIBLE);
                result.setVisibility(View.INVISIBLE);
                resultConfirmCallBack.run();
            }
        });

        resultClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                link.setVisibility(View.VISIBLE);
                load.setVisibility(View.INVISIBLE);
                guest.setVisibility(View.INVISIBLE);
                result.setVisibility(View.INVISIBLE);
                resultConfirmCallBack.run();
            }
        });

        //linkClose.setOnClickListener(closeListener);
        linkClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                closeCallBack.run();
            }
        });
        loadClose.setOnClickListener(closeListener);
        guestcClose.setOnClickListener(closeListener);

    }

    public Runnable loadConfirmCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("loadConfirmCallBack");
        }
    };

    public Runnable guestConfirmCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("guestConfirmCallBack");
        }
    };

    public Runnable resultConfirmCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("resultConfirmCallBack");
        }
    };

    public Runnable closeCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("loadConfirmCallBack");
        }
    };




    @Override
    protected void onStart() {
        super.onStart();

        linkSnsDataText.setText(linkSnsDataTextSupplier.get());
        linkGuestDataText.setText(linkGuestDataTextSupplier.get());

        loadText.setText(loadTextSupplier.get());

        guestText.setText(guestTextSupplier.get());
    }

    public CustormSupplier<String> linkSnsDataTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLink_middelLabel);
        }
    };

    public CustormSupplier<String> linkGuestDataTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLink_bottomLabel);
        }
    };

    public CustomFunction<String, Boolean> confirmCheck = new CustomFunction<String, Boolean>() {
        @Override
        public Boolean apply(String s) {
            if (s.equals("confirm")) {
                return true;
            } else {
                return false;
            }
        }
    };

    public CustormSupplier<String> loadTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLoad_content);
        }
    };

    public CustormSupplier<String> guestTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userGuest_middle);
        }
    };
}
