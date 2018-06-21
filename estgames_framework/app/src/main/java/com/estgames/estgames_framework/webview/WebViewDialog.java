package com.estgames.estgames_framework.webview;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.estgames.estgames_framework.R;

public class WebViewDialog extends Dialog {
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
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        setContentView(R.layout.webview);

        webView = (WebView) findViewById(R.id.webView_View);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

        webView.loadUrl(url);

        findViewById(R.id.btn_web_view_close).bringToFront();
        findViewById(R.id.btn_web_view_close).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }
}
