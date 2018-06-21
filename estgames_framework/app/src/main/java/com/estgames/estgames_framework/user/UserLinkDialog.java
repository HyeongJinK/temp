package com.estgames.estgames_framework.user;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.estgames.estgames_framework.R;


/**
 * Created by mp on 2018. 4. 3..
 */

public class UserLinkDialog extends Dialog {
    Activity activity;
    private Button closeBt;
    private Button confirmBt;
    private Button cancelBt;
    private TextView userLinkSnsDataText;
    private TextView userLinkGuestDataText;

    public Runnable confirmCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("confirmCallBack");
        }
    };
    public Runnable cancelCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("cancelCallBack");
        }
    };
    public Runnable closeCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("closeCallBack");
        }
    };

    public UserLinkDialog(Activity activity) {
        super((Context) activity);
        this.activity = activity;
    }

    public UserLinkDialog(Activity activity, Runnable confirmCallBack, Runnable cancelCallBack, Runnable closeCallBack) {
        super((Context) activity);
        this.activity = activity;
        this.confirmCallBack = confirmCallBack;
        this.cancelCallBack = cancelCallBack;
        this.closeCallBack = closeCallBack;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.userlink);

        confirmBt = (Button) findViewById(R.id.userLinkConfirm);
        cancelBt = (Button) findViewById(R.id.userLinkCancel);
        closeBt = (Button) findViewById(R.id.userLinkCloseBt);


        confirmBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                new Handler(Looper.getMainLooper()).post(confirmCallBack);
            }
        });

        cancelBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                cancelCallBack.run();
            }
        });

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                closeCallBack.run();
            }
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        this.confirmCallBack = confirmCallBack;
        this.cancelCallBack = cancelCallBack;
        this.closeCallBack = closeCallBack;

        userLinkSnsDataText = (TextView) findViewById(R.id.userLinkSnsDataText);
        userLinkGuestDataText = (TextView) findViewById(R.id.userLinkGuestDataText);
    }
}
