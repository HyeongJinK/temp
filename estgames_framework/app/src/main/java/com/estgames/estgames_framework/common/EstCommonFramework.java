package com.estgames.estgames_framework.common;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import com.estgames.estgames_framework.authority.AuthorityDialog;
import com.estgames.estgames_framework.banner.BannerCacheRepository;
import com.estgames.estgames_framework.banner.BannerDialog;
import com.estgames.estgames_framework.banner.BannerDialogHandler;
import com.estgames.estgames_framework.core.Api;
import com.estgames.estgames_framework.core.Fail;
import com.estgames.estgames_framework.core.HttpResponse;
import com.estgames.estgames_framework.core.PlatformContext;
import com.estgames.estgames_framework.core.Token;
import com.estgames.estgames_framework.core.session.SessionManager;
import com.estgames.estgames_framework.policy.PolicyDialog;
import com.estgames.estgames_framework.webview.WebViewDialog;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


/**
 * Created by mp on 2018. 4. 26..
 */

public class EstCommonFramework {
    private String TAG = "EMP Common";
    private PlatformContext platformContext;

    private ProcessDescription pd;
    private SessionManager sessionManager;

    final String SystemContract = "system_contract";
    final String UseContract = "use_contract";
    final String Banner = "banner";

    SharedPreferences pref;
    Context context;

    AuthorityDialog authorityDialog;
    BannerDialog bannerDialog;
    PolicyDialog policyDialog;

    WebViewDialog notice;
    WebViewDialog cscenter;

    public Runnable bannerCallBack = new Runnable() {
        @Override public void run() {}
    };

    public Runnable authorityCallBack = new Runnable() {
        @Override public void run() {}
    };

    public Runnable policyCallBack = new Runnable() {
        @Override public void run() {}
    };

    public Runnable processCallBack = new Runnable() {
        @Override public void run() {}
    };

    public CustomConsumer initCallBack = new CustomConsumer<EstCommonFramework>() {
        @Override public void accept(EstCommonFramework o) {}
    };

    public CustomConsumer<Fail> estCommonFailCallBack = new CustomConsumer<Fail>() {
        @Override public void accept(Fail code) {}
    };

    public EstCommonFramework(Context context) {
        this.context = context;
        platformContext = (PlatformContext) context.getApplicationContext();
        sessionManager = new SessionManager(context);

        pref = this.context.getSharedPreferences("policy", Activity.MODE_PRIVATE);
    }

    public EstCommonFramework(Context context, CustomConsumer<EstCommonFramework> initCallBack) {
        this.context = context;
        platformContext = (PlatformContext) context.getApplicationContext();
        sessionManager = new SessionManager(context);

        this.initCallBack = initCallBack;
        pref = this.context.getSharedPreferences("policy", Activity.MODE_PRIVATE);
    }

    public void create() {
        EstCommonFramework temp = this;
        try {
            Thread startApi = new Thread() {
                @Override
                public void run() {
                    try {
                        HttpResponse result = new Api.ProcessDescribe(
                                platformContext.getConfiguration().getRegion(), Locale.getDefault().getLanguage()
                        ).invoke();

                        pd = ProcessDescriptionParser.parse(new String(result.getContent(), "utf-8"));

                        initCallBack.accept(temp);
                    } catch (Exception e) {
                        Log.e(TAG, "Fail to initialize process...", e);
                        estCommonFailCallBack.accept(Fail.API_REQUEST_FAIL);
                    }
                }
            };

            startApi.start();
        } catch (Exception e) {
            Log.e(TAG, "Fail to initialize process...", e);
            estCommonFailCallBack.accept(Fail.API_REQUEST_FAIL);
        }
    }

    public void bannerShow() {
        if (pd != null) {
            BannerCacheRepository cache = new BannerCacheRepository(context);
            List<Banner> banners = new ArrayList<>();
            for (Banner b: pd.getBanners()) {
                if (!cache.isHideOnToday(b.getName())) {banners.add(b);}
            }

            if (banners.size() > 0) {
                bannerDialog = new BannerDialog(context, banners, cache);
                bannerDialog.setDialogHandler(new BannerDialogHandler() {
                    @Override public void onDialogClosed() {
                        cache.dispose();
                        bannerCallBack.run();
                    }
                });
                bannerDialog.show();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private void pBannerShow() {
        if (pd != null) {
            BannerCacheRepository cache = new BannerCacheRepository(context);
            List<Banner> banners = new ArrayList<>();
            for (Banner b: pd.getBanners()) {
                if (!cache.isHideOnToday(b.getName())) {banners.add(b);}
            }

            if (banners.size() > 0) {
                bannerDialog = new BannerDialog(context, pd.getBanners(), cache);
                bannerDialog.setDialogHandler(new BannerDialogHandler() {
                    @Override public void onDialogClosed() {
                        cache.dispose();
                        bannerCallBack.run();
                    }
                });
                bannerDialog.show();
            } else {
                defaultProcess();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public void authorityShow() {
        if (pd != null) {
            authorityDialog = new AuthorityDialog(context, pd.getUrl().getAuthority(), authorityCallBack);
            authorityDialog.show();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private boolean policyCheck() {
        if (pref.getString("estPolicy", "false").equals("true"))
            return true;
        else
            return false;
    }


    public void policyShow() {
        if (pd != null) {
            if (!policyCheck()) {
                policyDialog = new PolicyDialog(context, pd.getUrl().getContractPrivate(), pd.getUrl().getContractService(), policyCallBack);
                policyDialog.show();
            }
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    private void pPolicyShow() {
        if (pd != null) {
            if (!policyCheck()) {
                policyDialog = new PolicyDialog(context, pd.getUrl().getContractPrivate(), pd.getUrl().getContractService(), policyCallBack);
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
        for(String process : pd.getProcess()) {
            if (process.equals(SystemContract)) {
                return true;
            }
        }
        return false;
    }

    Runnable processCheck = new Runnable() {
        @Override
        public void run() {
            if (pd.getProcess().length <= index) {
                processCallBack.run();
                return;
            }
            String process = pd.getProcess()[index++];

            switch (process) {
                case SystemContract :
                    defaultProcess();
                    break;
                case UseContract :
                    policyCallBack = processCheck;
                    pPolicyShow();
                    break;
                case Banner :
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
        if (pd != null) {
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
        Token token = sessionManager.getToken();
        if (pd != null) {
            notice = new WebViewDialog(context, pd.getUrl().getNotice() + "?eg_token=" + token.getEgToken() + "&lang=" + pd.getLanguage());
            notice.show();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public void showCSCenter() {
        Token token = sessionManager.getToken();
        if (pd != null) {
            cscenter = new WebViewDialog(context, pd.getUrl().getCs() + "?eg_token=" + token.getEgToken() + "&lang=" + pd.getLanguage());
            cscenter.show();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public void showEvent() {
        Token token = sessionManager.getToken();
        if (pd != null) {
            String url = String.format("%s?eg_token=%s&lang=%s", pd.getUrl().getEvent(), token.getEgToken(), pd.getLanguage());
            WebViewDialog eventDialog = new WebViewDialog(context, url);
            eventDialog.show();
        } else {
            estCommonFailCallBack.accept(Fail.START_API_NOT_CALL);
        }
    }

    public String getNation() {
        return pd.getNation();
    }

    public String getLanguage() {
        return Locale.getDefault().getLanguage();
    }
}
