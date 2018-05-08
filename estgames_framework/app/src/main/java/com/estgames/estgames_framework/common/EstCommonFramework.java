package com.estgames.estgames_framework.common;

import android.content.Context;
import android.content.SharedPreferences;
import com.estgames.estgames_framework.authority.AuthorityDialog;
import com.estgames.estgames_framework.banner.BannerDialog;
import com.estgames.estgames_framework.core.HttpRequest;
import com.estgames.estgames_framework.core.HttpResponse;
import com.estgames.estgames_framework.core.Method;
import com.estgames.estgames_framework.policy.PolicyDialog;

import kotlin.text.Charsets;

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

    public Runnable initCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("initCallBack");
        }
    };

    public void setBannerCallBack(Runnable callBack) {
        bannerDialog.callback = callBack;
    }

    public EstCommonFramework(Context context) {
        this.context = context;
        new Thread() {
            @Override
            public void run() {
                HttpResponse result = request(apiUrl, Method.GET);

                data = new ResultDataJson(new String(result.getContent()));

                initCallBack.run();
            }
        }.start();
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
}
