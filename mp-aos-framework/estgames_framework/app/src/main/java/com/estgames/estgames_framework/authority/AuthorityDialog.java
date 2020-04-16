package com.estgames.estgames_framework.authority;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
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
import com.estgames.estgames_framework.common.ClientPreferences;
import com.estgames.estgames_framework.core.AndroidUtils;

import static android.R.style.Theme_NoTitleBar_Fullscreen;

/**
 * Created by mp on 2018. 3. 20..
 */

public class AuthorityDialog extends Dialog {
    private ClientPreferences preferences;
    private String url;

    private Runnable callback = new Runnable() {
        @Override
        public void run() {

        }
    };

    public AuthorityDialog(@NonNull Context context, ClientPreferences pref, String url) {
        this(context, pref, url, new Runnable() {
            @Override public void run() {}
        });
    }

    public AuthorityDialog(@NonNull Context context, ClientPreferences pref, String url, Runnable callback) {
        super(context, Theme_NoTitleBar_Fullscreen);
        this.url = url;
        this.callback = callback;
        preferences = pref;
    }

    public void setWebViewUrl (String url) {
        setPermissionView(url);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.authority);

        setTitle();
        setPermissionView(url);
        setButtons();

        this.setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                callback.run();
            }
        });
    }

    private void setTitle() {
        TextView txtTitle = findViewById(R.id.txt_title);
        String titleText = getLocaleText(R.string.estcommon_authority_title);

        //타이틀
        //String tempStr = "<font color=\"#5C9AFF\">원활한 게임플레이</font>를 위해 아래 <font color=\"#5C9AFF\">권한</font>을 필요로 합니다.";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            txtTitle.setText(Html.fromHtml(titleText, Html.FROM_HTML_MODE_LEGACY));
        } else {
            txtTitle.setText(Html.fromHtml(titleText.toString()));
        }
    }

    private void setPermissionView(String target) {
        WebView view  = findViewById(R.id.web_permissions);

        if (target != null && target != "") {
            //웹 뷰
            WebSettings webSettings = view.getSettings();
            webSettings.setJavaScriptEnabled(true);
            view.setWebViewClient(new WebViewClient() {
                @Override
                public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                    return super.shouldOverrideUrlLoading(view, request);
                }
            });

            view.loadUrl(target);
        }
    }

    private void setButtons() {
        Button btnClose = (Button) findViewById(R.id.btn_close);
        btnClose.setText(getLocaleText(R.string.estcommon_authority_confirm));

        btnClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    private String getLocaleText(int resourceId) {
        return AndroidUtils.getLocaleText(resourceId, preferences.getLocale(), getContext()).toString();
    }
}
