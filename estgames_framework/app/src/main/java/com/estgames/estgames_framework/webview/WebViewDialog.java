package com.estgames.estgames_framework.webview;

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

import com.estgames.estgames_framework.R;

public class WebViewDialog extends Dialog {
    Dialog dialog;
    Button closeBt;
    WebView webView;
    String url;
    Runnable callBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("webViewCallBack");
        }
    };

    public WebViewDialog(@NonNull Context context, String url) {
        super(context);
        this.url = url;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        dialog = this;
        setContentView(R.layout.webview);

        closeBt = (Button) findViewById(R.id.webView_CloseBt);
        webView = (WebView) findViewById(R.id.webView_View);

        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) { return super.shouldOverrideUrlLoading(view, request);
            }
        });

        webView.loadUrl(url);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
    }
}
