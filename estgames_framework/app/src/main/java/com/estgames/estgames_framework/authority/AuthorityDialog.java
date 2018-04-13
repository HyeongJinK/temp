package com.estgames.estgames_framework.authority;

import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.text.Html;
import android.view.View;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.TextView;

import com.estgames.estgames_framework.R;

import static android.R.style.Theme_NoTitleBar_Fullscreen;

/**
 * Created by mp on 2018. 3. 20..
 */

public class AuthorityDialog extends Dialog {
    Dialog dialog;
    TextView title;
    WebView webView;
    Button closeBt;

    public AuthorityDialog(@NonNull Context context, SharedPreferences pref) {
        super(context, Theme_NoTitleBar_Fullscreen);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        dialog = this;
        setContentView(R.layout.authority);

        //TODO json 데이터 가져오기

        //타이틀
        String tempStr = "<font color=\"#5C9AFF\">원활한 게임플레이</font>를 위해 아래 <font color=\"#5C9AFF\">권한</font>을 필요로 합니다.";
        title = (TextView) findViewById(R.id.authority_title);
        title.setText(Html.fromHtml(tempStr, Html.FROM_HTML_MODE_LEGACY));

        //웹 뷰
        webView = (WebView) findViewById(R.id.authority_webView);
        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

        webView.loadUrl("https://translate.google.co.kr/?hl=ko");

        //닫기 버튼
        closeBt = (Button) findViewById(R.id.authority_bt);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
    }
}
