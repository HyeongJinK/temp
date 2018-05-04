package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.Button;

import com.estgames.estgames_framework.R;

/**
 * Created by mp on 2018. 5. 3..
 */

public class UserGuestLinkDialog extends Dialog {
    Dialog self;
    Button closeBt;
    Button loginBt;
    Button beforeBt;

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

    public UserGuestLinkDialog(@NonNull Context context) {
        super(context);
    }

    public UserGuestLinkDialog(@NonNull Context context, Runnable closeCallBack, Runnable loginCallBack, Runnable beforeCallBack) {
        super(context);
        this.closeCallBack = closeCallBack;
        this.loginCallBack = loginCallBack;
        this.beforeCallBack = beforeCallBack;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        self = this;
        setContentView(R.layout.userguestlink);

        closeBt = (Button) findViewById(R.id.userGuestLinkCloseBt);
        loginBt = (Button) findViewById(R.id.userGuestLinkLoginBt);
        beforeBt = (Button) findViewById(R.id.userGuestLinkBeforeBt);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss();
                closeCallBack.run();
            }
        });

        loginBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss();
                loginCallBack.run();
            }
        });

        beforeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss();
                beforeCallBack.run();
            }
        });
    }
}
