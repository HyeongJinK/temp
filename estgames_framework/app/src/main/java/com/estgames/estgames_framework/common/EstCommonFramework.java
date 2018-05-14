package com.estgames.estgames_framework.common;

import android.content.Context;
import android.content.SharedPreferences;

import com.estgames.estgames_framework.authority.AuthorityDialog;
import com.estgames.estgames_framework.banner.BannerDialog;
import com.estgames.estgames_framework.core.HttpResponse;
import com.estgames.estgames_framework.core.Method;
import com.estgames.estgames_framework.core.Profile;
import com.estgames.estgames_framework.core.Token;
import com.estgames.estgames_framework.core.session.SessionManager;
import com.estgames.estgames_framework.policy.PolicyDialog;
import com.estgames.estgames_framework.webview.WebViewDialog;

import static com.estgames.estgames_framework.core.HttpUtils.request;


/**
 * Created by mp on 2018. 4. 26..
 */

public class EstCommonFramework {
    String apiUrl = "https://m-linker.estgames.co.kr/sdk-start-api";
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

    public void create() {
        EstCommonFramework temp = this;
        new Thread() {
            @Override
            public void run() {
                HttpResponse result = request(apiUrl, Method.GET);

                data = new ResultDataJson(new String(result.getContent()));

                initCallBack.accept(temp);
            }
        }.start();
    }

    public EstCommonFramework(Context context) {
        this.context = context;

//        new Thread() {
//            @Override
//            public void run() {
//                HttpResponse result = request(apiUrl, Method.GET);
//
//                data = new ResultDataJson(new String(result.getContent()));
//
//                initCallBack.run();
//            }
//        }.start();
    }

    public EstCommonFramework(Context context, CustomConsumer<EstCommonFramework> initCallBack) {
        this.context = context;
        this.initCallBack = initCallBack;
    }

    public void bannerShow() {
        if (data != null) {
            bannerDialog = new BannerDialog(context, data, bannerCallBack);
            bannerDialog.show();
        }
    }

    public void authorityShow() {
        if (data != null) {
            authorityDialog = new AuthorityDialog(context, data.getUrl().getSystem_contract(), authorityCallBack);
            authorityDialog.show();
        }
    }

    public void policyShow() {
        if (data != null) {
            policyDialog = new PolicyDialog(context, data.getUrl().getContract_private(), data.getUrl().getContract_service(), policyCallBack);
            policyDialog.show();
        }
    }

    public boolean contractService() {
        return policyDialog.contractService();
        //policyDialog
    }

    public boolean contractPrivate() {
        return policyDialog.contractPrivate();
    }
    int index = 0;

    Runnable processCheck = new Runnable() {
        @Override
        public void run() {
            if (data.getProcess().size() <= index) {
                return;
            }

            String process = data.getProcess().get(index++);
            switch (process) {
                case "system_contract" :
                    authorityCallBack = processCheck;
                    authorityShow();
                    break;
                case "use_contract" :
                    policyCallBack = processCheck;
                    policyShow();
                    break;
                case "event" :
                    bannerCallBack = processCallBack;
                    bannerShow();
                    break;
                default:
                    defaultProcess();
                    break;
            }
        }
    };

    public void processShow() {
        index = 0;
        processCheck.run();
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
            }
        }
    }

    public void showCSCenter() {
        SessionManager sm = new SessionManager(context);
        if (sm != null) {
            Token token = sm.getToken();
            if (data != null) {
                cscenter = new WebViewDialog(context, data.getUrl().getCscenter() + "?eg_token=" + token.getEgToken() + "&lang=" + data.getLanguage());
                cscenter.show();
            }
        }
    }
}
