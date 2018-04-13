package com.estgames.estgames_framework.policy;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.webkit.WebView;
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

    boolean checked1 = false;
    boolean checked2 = false;

    public PolicyDialog(Context context) {
        super(context);
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

        policyClosebt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });

        policybt1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checked1 = !checked1;

                if (checked1 && checked2) {
                    dismiss();
                }
            }
        });

        policybt2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checked2 = !checked2;

                if (checked1 && checked2) {
                    dismiss();
                }
            }
        });
    }
}
