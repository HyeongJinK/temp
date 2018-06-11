package com.estgames.estgames_framework.webview;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.Window;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;

import com.estgames.estgames_framework.R;

public class WebViewDialog extends Dialog {
    private Button closeBt;
    private WebView webView;
    private String url;
    private Runnable callBack = new Runnable() {
        @Override
        public void run() {}
    };

    public WebViewDialog(@NonNull Context context, String url) {
        super(context, android.R.style.Theme_NoTitleBar_Fullscreen);
        this.url = url;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.webview);

        closeBt = (Button) findViewById(R.id.webView_CloseBt);
        webView = (WebView) findViewById(R.id.webView_View);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

        webView.loadUrl(url);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }
}
