package com.estgames.estgames_framework.common;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.estgames.estgames_framework.authority.AuthorityDialog;
import com.estgames.estgames_framework.banner.BannerDialog;
import com.estgames.estgames_framework.banner.BannerJson;
import com.estgames.estgames_framework.banner.Entry;
import com.estgames.estgames_framework.policy.PolicyDialog;

import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import static kotlin.text.Typography.amp;

/**
 * Created by mp on 2018. 4. 26..
 */

public class EstCommonFramework {
    String apiUrl = "https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/stage/start/mr";
    SharedPreferences pref;

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

    public void setBannerCallBack(Runnable callBack) {
        bannerDialog.callback = callBack;
    }

    public EstCommonFramework(Context context, SharedPreferences pref) {
        this.pref = pref;


        RequestQueue queue = Volley.newRequestQueue(context);

        JsonObjectRequest jsObjRequest = new JsonObjectRequest(Request.Method.GET, apiUrl, null, new Response.Listener<JSONObject>() {

            @Override
            public void onResponse(JSONObject response) {
                System.out.println(response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });






//        StringRequest stringRequest = new StringRequest(apiUrl
//                , new Response.Listener<String>() {
//            @Override
//            public void onResponse(String response) {
//                System.out.println(response);
//                //data = new ResultDataJson(response);
////                bannerDialog = new BannerDialog(context, pref, data, bannerCallBack);
////                authorityDialog = new AuthorityDialog(context, data.getUrl().getSystem_contract());
////                policyDialog = new PolicyDialog(context, data.getUrl().getContract_private(), data.getUrl().getContract_service());
//            }
//        }, new Response.ErrorListener() {
//            @Override
//            public void onErrorResponse(VolleyError error) {
//                System.out.println("ERROR VOLLEY ERROR");
//            }
//        });

        queue.add(jsObjRequest);
    }

    public void bannerShow() {
        bannerDialog.show();
    }

    public void authorityShow() {
        authorityDialog.show();
    }

    public void policyShow() {
        policyDialog.show();
    }

    public boolean contractService() {
        return policyDialog.contractService();
        //policyDialog
    }

    public boolean contractPrivate() {
        return policyDialog.contractPrivate();
    }
}
