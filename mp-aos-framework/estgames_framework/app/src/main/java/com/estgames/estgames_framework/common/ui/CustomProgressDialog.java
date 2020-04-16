package com.estgames.estgames_framework.common.ui;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.Window;
import android.widget.TextView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.ClientPreferences;
import com.estgames.estgames_framework.core.AndroidUtils;

public class CustomProgressDialog extends Dialog {
    private ClientPreferences preferences;
    private String message;

    public CustomProgressDialog(@NonNull Context context, ClientPreferences preferences) {
        this(context, preferences,0);
    }

    public CustomProgressDialog(@NonNull Context context, ClientPreferences preferences, int themeResId) {
        super(context, themeResId);
        this.preferences = preferences;
        setCancelable(false);
    }

    public void setMessage(int resourceId) {
        this.message = AndroidUtils.getLocaleText(resourceId, preferences.getLocale(), getContext()).toString();
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.progress_dialog_layout);

        TextView txtMessage = findViewById(R.id.txt_progress_message);
        txtMessage.setText(this.message);
    }

    public void hideMessage() {
        findViewById(R.id.lay_progress_dialog).setVisibility(View.INVISIBLE);
        findViewById(R.id.prg_loading).setVisibility(View.INVISIBLE);
        findViewById(R.id.txt_progress_message).setVisibility(View.INVISIBLE);
    }
}
