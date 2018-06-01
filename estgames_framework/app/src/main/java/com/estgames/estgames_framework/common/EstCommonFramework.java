package com.estgames.estgames_framework.common;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

import com.estgames.estgames_framework.authority.AuthorityDialog;
import com.estgames.estgames_framework.banner.BannerDialog;
import com.estgames.estgames_framework.core.Fail;
import com.estgames.estgames_framework.core.HttpResponse;
import com.estgames.estgames_framework.core.Method;
import com.estgames.estgames_framework.core.Token;
import com.estgames.estgames_framework.core.session.SessionManager;
import com.estgames.estgames_framework.policy.PolicyDialog;
import com.estgames.estgames_framework.webview.WebViewDialog;

import java.util.Locale;

import static com.estgames.estgames_framework.core.HttpUtils.request;


/**
 * Created by mp on 2018. 4. 26..
 */

public class EstCommonFramework {
    final String apiUrl = "https://m-linker.estgames.co.kr/sdk-start-api?lang="+Locale.getDefault().getLanguage();
    final String SystemContract = "system_contract";
    final String UseContract = "use_contract";
    final String Event = "event";

    SharedPreferences pref;
    Context context;

    AuthorityDialog authorityDialog;
    BannerDialog bannerDialog;
    PolicyDialog policyDialog;

    ResultDataJson data;

    WebViewDialog notice;
    WebViewDialog cscenter;

    public Runnable bannerCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("callBack");
        }
    };

    public Runnable authorityCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("authorityCallBack");
        }
    };

    public Runnable policyCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("policyCallBack");
        }
    };

    public Runnable processCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("processCallBack");
        }
    };

    public CustomConsumer initCallBack = new CustomConsumer<EstCommonFramework>() {
        @Override
        public void accept(EstCommonFramework o) {
            System.out.println("initCallBack");
        }
    };

    public CustomConsumer<Fail> estCommonFailCallBack = new CustomConsumer<Fail>() {
        @Override
        public void accept(Fail code) {

        }
    };

    public void create() {
        EstCommonFramework temp = this;
        try {
            Thread startApi = new Thread() {
                @Override
                public void run() {
                    try {
                        HttpResponse result = request(apiUrl, Method.GET);

                        data = new ResultDataJson(new String(result.getContent()));

                        initCallBack.accept(temp);
                    } catch (Exception e) {
                        e.printStackTrace();
                        estCommonFailCallBack.accept(Fail.API_REQUEST_FAIL);
                    }
                }
            };

            startApi.start();
            //startApi.
        } catch (Exception e) {
            e.printStackTrace();
            estCommonFailCallBack.accept(Fail.API_REQUEST_FAIL);
        }
    }

    public EstCommonFramework(Context context) {
        this.context = context;
        pref = this.context.getSharedPreferences("policy", Activity.MODE_PRIVATE);
    }

    public EstCommonFramework(Context context, CustomConsumer<EstCommonFramework> initCallBack) {
        this.context = context;
        this.initCallBack = initCallBack;
        pref = this.context.getSharedPreferences("policy", Activity.MODE_PRIVATE);
    }

    public void bannerShow() {
        if (data != null) {
            bannerDialog = new BannerDialog(context, data, bannerCallBack);
            if (bannerDialog.bitmap.size() > 0) {
                bannerDialog.show();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private void pBannerShow() {
        if (data != null) {
            bannerDialog = new BannerDialog(context, data, bannerCallBack);
            if (bannerDialog.bitmap.size() > 0) {
                bannerDialog.show();
            } else {
                defaultProcess();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public void authorityShow() {
        if (data != null) {
            authorityDialog = new AuthorityDialog(context, data.getUrl().getSystem_contract(), authorityCallBack);
            authorityDialog.show();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private boolean policyCheck() {
        if (policyCheck())
            return true;
        else
            return false;
    }

    public void defaultPolicyShow() {

    }

    public void policyShow() {
        if (data != null) {
            if (!policyCheck()) {
                policyDialog = new PolicyDialog(context, data.getUrl().getContract_private(), data.getUrl().getContract_service(), policyCallBack);
                policyDialog.show();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private void pPolicyShow() {
        if (data != null) {
            if (!policyCheck()) {
                policyDialog = new PolicyDialog(context, data.getUrl().getContract_private(), data.getUrl().getContract_service(), policyCallBack);
                policyDialog.show();
            } else {
                defaultProcess();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public boolean contractService() {
        if (policyCheck())
            return true;
        if (policyDialog == null)
            return false;
        return policyDialog.contractService();
    }

    public boolean contractPrivate() {
        if (policyCheck())
            return true;
        if (policyDialog == null)
            return false;
        return policyDialog.contractPrivate();
    }
    int index = 0;

    public boolean systemContractShowOrDismiss() {
        for(String process : data.getProcess()) {
            if (process.equals(SystemContract)) {
                return true;
            }
        }
        return false;
    }

    Runnable processCheck = new Runnable() {
        @Override
        public void run() {
            if (data.getProcess().size() <= index) {
                processCallBack.run();
                return;
            }
            String process = data.getProcess().get(index++);

            switch (process) {
                case SystemContract :
//                    authorityCallBack = processCheck;
//                    authorityShow();
                    defaultProcess();
                    break;
                case UseContract :
                    policyCallBack = processCheck;
                    pPolicyShow();
                    break;
                case Event :
                    bannerCallBack = processCheck;
                    pBannerShow();
                    break;
                default:
                    defaultProcess();
                    break;
            }
        }
    };

    public void processShow() {
        if (data != null) {
            index = 0;
            processCheck.run();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private void defaultProcess() {
        processCheck.run();
    }

    public void showNotice() {
        SessionManager sm = new SessionManager(context);
        if (sm != null) {
            Token token = sm.getToken();

            if (data != null) {
                notice = new WebViewDialog(context, data.getUrl().getNotice() + "?eg_token=" + token.getEgToken() + "&lang=" + data.getLanguage());
                notice.show();
            } else {
                estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
            }
        } else {
            estCommonFailCallBack.accept(Fail.TOKEN_EMPTY);
        }
    }

    public void showCSCenter() {
        SessionManager sm = new SessionManager(context);
        if (sm != null) {
            Token token = sm.getToken();
            if (data != null) {
                cscenter = new WebViewDialog(context, data.getUrl().getCscenter() + "?eg_token=" + token.getEgToken() + "&lang=" + data.getLanguage());
                cscenter.show();
            } else {
                estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
            }
        } else {
            estCommonFailCallBack.accept(Fail.TOKEN_EMPTY);
        }
    }

    public String getNation() {
        return data.getNation();
    }

    public String getLanguage() {
        return Locale.getDefault().getLanguage();
    }
}
