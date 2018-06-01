package com.estgames.estgames_framework.policy;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.CheckBox;
import android.widget.ImageButton;

import com.estgames.estgames_framework.R;

/**
 * Created by mp on 2018. 3. 20..
 */

public class PolicyDialog extends Dialog {
    ImageButton policyClosebt;
    WebView policyWebView1;
    WebView policyWebView2;
    CheckBox policybt1;
    CheckBox policybt2;

    String serviceUrl;
    String privateUrl;
    SharedPreferences pref;
    SharedPreferences.Editor prefEdit;

    Runnable callback = new Runnable() {
        @Override
        public void run() {

        }
    };
    //Runnable closeCallback;

    boolean checked1 = false;
    boolean checked2 = false;

    public PolicyDialog(Context context) {
        super(context);
    }

    public PolicyDialog(Context context, String serviceUrl, String privateUrl) {
        super(context);
        this.serviceUrl = serviceUrl;
        this.privateUrl = privateUrl;
    }
    public PolicyDialog(Context context, String serviceUrl, String privateUrl, Runnable callback) {
        super(context);
        this.serviceUrl = serviceUrl;
        this.privateUrl = privateUrl;
        this.callback = callback;
    }


    public Boolean contractService() {
        return checked1;
    }

    public Boolean contractPrivate() {
        return checked2;
    }

    public void setContractService (String url) {
        policyWebView1.loadUrl(url);
    }

    public void setContractPrivate (String url) {
        policyWebView2.loadUrl(url);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.policy);

        this.pref = getContext().getSharedPreferences("policy", Activity.MODE_PRIVATE);
        prefEdit = this.pref.edit();

        policyClosebt = (ImageButton) findViewById(R.id.policyClosebt);
        policyWebView1 = (WebView) findViewById(R.id.policyWebView1);
        policyWebView2 = (WebView) findViewById(R.id.policyWebView2);
        policybt1 = (CheckBox) findViewById(R.id.policybt1);
        policybt2 = (CheckBox) findViewById(R.id.policybt2);


        if (serviceUrl != null && serviceUrl != "") {
            WebSettings webSettings = policyWebView1.getSettings();
            webSettings.setJavaScriptEnabled(true);

            policyWebView1.setWebViewClient(new WebViewClient() {
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    return super.shouldOverrideUrlLoading(view, request);
                }
            });

            policyWebView1.loadUrl(serviceUrl);
        }

        if (privateUrl != null && privateUrl != "") {
            WebSettings webSettings2 = policyWebView2.getSettings();
            webSettings2.setJavaScriptEnabled(true);

            policyWebView2.setWebViewClient(new WebViewClient() {
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    return super.shouldOverrideUrlLoading(view, request);
                }
            });

            policyWebView2.loadUrl(privateUrl);
        }

        policyClosebt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                callback.run();
            }
        });

        policybt1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checked1 = !checked1;

                if (checked1 && checked2) {
                    prefEdit.putString("estPolicy", "true");
                    prefEdit.commit();
                    dismiss();
                    callback.run();
                }
            }
        });

        policybt2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checked2 = !checked2;

                if (checked1 && checked2) {
                    prefEdit.putString("estPolicy", "true");
                    prefEdit.commit();
                    dismiss();
                    callback.run();
                }
            }
        });
    }
}
