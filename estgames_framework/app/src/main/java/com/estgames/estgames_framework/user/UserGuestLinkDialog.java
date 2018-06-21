package com.estgames.estgames_framework.user;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.estgames.estgames_framework.R;


/**
 * Created by mp on 2018. 5. 3..
 */

public class UserGuestLinkDialog extends Dialog {
    Activity activity;
    Button closeBt;
    Button loginBt;
    Button beforeBt;
    TextView userGuestText;

    public Runnable closeCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("closeCallBack");
        }
    };
    public Runnable loginCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("loginCallBack");
        }
    };
    public Runnable beforeCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("beforeCallBack");
        }
    };

    public UserGuestLinkDialog(@NonNull Activity context) {
        super(context);
        this.activity = context;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.userguestlink);

        closeBt = (Button) findViewById(R.id.userGuestLinkCloseBt);
        loginBt = (Button) findViewById(R.id.userGuestLinkLoginBt);
        beforeBt = (Button) findViewById(R.id.userGuestLinkBeforeBt);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dismiss();
                        closeCallBack.run();
                    }
                });
            }
        });

        loginBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dismiss();
                        loginCallBack.run();
                    }
                });
            }
        });

        beforeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dismiss();
                        beforeCallBack.run();
                    }
                });
            }
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        this.closeCallBack = closeCallBack;
        this.loginCallBack = loginCallBack;
        this.beforeCallBack = beforeCallBack;
        userGuestText = (TextView) findViewById(R.id.userGuestLinkMiddleText);
    }
}
