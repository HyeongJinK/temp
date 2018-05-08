package com.estgames.estgames_framework.policy;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.ImageButton;

import com.estgames.estgames_framework.R;

/**
 * Created by mp on 2018. 3. 20..
 */

public class PolicyDialog extends Dialog {
    ImageButton policyClosebt;
    WebView policyWebView1;
    WebView policyWebView2;
    Button policybt1;
    Button policybt2;

    String serviceUrl;
    String privateUrl;

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
        setContentView(R.layout.policy);

        policyClosebt = (ImageButton) findViewById(R.id.policyClosebt);
        policyWebView1 = (WebView) findViewById(R.id.policyWebView1);
        policyWebView2 = (WebView) findViewById(R.id.policyWebView2);
        policybt1 = (Button) findViewById(R.id.policybt1);
        policybt2 = (Button) findViewById(R.id.policybt2);


        WebSettings webSettings = policyWebView1.getSettings();
        webSettings.setJavaScriptEnabled(true);
        policyWebView1.loadUrl(serviceUrl);

        policyWebView1.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

        WebSettings webSettings2 = policyWebView2.getSettings();
        webSettings2.setJavaScriptEnabled(true);
        policyWebView2.loadUrl(privateUrl);

        policyWebView2.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

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
                    dismiss();
                    callback.run();
                }
            }
        });
    }
}
