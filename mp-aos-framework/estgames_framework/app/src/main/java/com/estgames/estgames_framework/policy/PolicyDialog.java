package com.estgames.estgames_framework.policy;

import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.CheckBox;
import android.widget.TextView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.ClientPreferences;
import com.estgames.estgames_framework.core.AndroidUtils;

/**
 * Created by mp on 2018. 3. 20..
 */
public class PolicyDialog extends Dialog {
    private ClientPreferences preferences;

    WebView webTermOfService;
    WebView webTermOfPrivacy;

    private String termOfService;
    private String termOfPrivacy;

    private Handler handler;

    boolean agreedToService = false;
    boolean agreedToPrivacy = false;

    public PolicyDialog(Context context, ClientPreferences pref) {
        this(context, null, null, pref);
    }

    public PolicyDialog(Context context, String service, String privacy, ClientPreferences pref) {
        super(context);
        termOfService = service;
        termOfPrivacy = privacy;
        this.preferences = pref;
    }

    public Boolean contractService() {
        return agreedToService;
    }

    public Boolean contractPrivate() {
        return agreedToPrivacy;
    }

    public void setContractService (String url) {
        webTermOfService.loadUrl(url);
    }

    public void setContractPrivate (String url) {
        webTermOfPrivacy.loadUrl(url);
    }

    public void setHanler(Handler h) {
        handler = h;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.policy);

        ((TextView)findViewById(R.id.txt_term_title)).setText(getLocaleText(R.string.estcommon_policy_title));

        findViewById(R.id.btn_term_close).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });

        setTermOfService();
        setTermOfPrivacy();

        // 다이얼로그 창이 닫혔을때 콜백을 실행하도록 수정.
        this.setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                if (agreedToService && agreedToPrivacy) {
                    handler.onAccepted();
                } else {
                    handler.onDenied("DENIED");
                }
            }
        });
    }

    private void setTermOfService() {
        ((TextView)findViewById(R.id.txt_title_for_term_of_service)).setText(getLocaleText(R.string.estcommon_policy_subTitle));

        webTermOfService = findAndSetView(R.id.web_term_of_service);

        if (termOfService != null && !termOfService.isEmpty()) {
            webTermOfService.loadUrl(termOfService);
        }

        CheckBox agreement = findViewById(R.id.chk_agreement_of_service);
        agreement.setText(getLocaleText(R.string.estcommon_policy_buttonText));
        agreement.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                agreedToService = !agreedToService;

                if (agreedToService && agreedToPrivacy) {
                    preferences.setTermsAgreement(true);
                    dismiss();
                }
            }
        });
    }

    private void setTermOfPrivacy() {
        TextView subTitle = findViewById(R.id.txt_title_for_term_of_privacy);
        if (subTitle != null) {
            subTitle.setText(getLocaleText(R.string.estcommon_policy_privacy));
        }

        webTermOfPrivacy = findAndSetView(R.id.web_term_of_privacy);

        if (termOfPrivacy != null && !termOfPrivacy.isEmpty()) {
            webTermOfPrivacy.loadUrl(termOfPrivacy);
        }

        CheckBox agreement = findViewById(R.id.chk_agreement_of_privacy);
        agreement.setText(getLocaleText(R.string.estcommon_policy_buttonText));
        agreement.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                agreedToPrivacy = !agreedToPrivacy;

                if (agreedToService && agreedToPrivacy) {
                    preferences.setTermsAgreement(true);
                    dismiss();
                }
            }
        });
    }

    private WebView findAndSetView(int resourceId) {
        WebView view = findViewById(resourceId);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            view.getSettings().setSafeBrowsingEnabled(false);
        }
        view.getSettings().setJavaScriptEnabled(true);
        view.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return super.shouldOverrideUrlLoading(view, request);
            }
        });

        return view;
    }

    private String getLocaleText(int resourceId) {
        return AndroidUtils.getLocaleText(resourceId, preferences.getLocale(), getContext()).toString();
    }

    public interface Handler {
        void onAccepted();
        void onDenied(String state);
    }
}
