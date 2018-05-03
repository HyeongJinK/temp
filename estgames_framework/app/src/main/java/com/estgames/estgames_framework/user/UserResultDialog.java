package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.Button;

import com.estgames.estgames_framework.R;

/**
 * Created by mp on 2018. 4. 3..
 */

public class UserResultDialog extends Dialog {
    Dialog self;
    Button closeBt;
    Button confirmBt;

    public Runnable closeCallBack = new Runnable() {
        @Override
        public void run() {

        }
    };
    public Runnable confirmCallBack = new Runnable() {
        @Override
        public void run() {

        }
    };

    public UserResultDialog(Context context) {
        super(context);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        self = this;
        setContentView(R.layout.userresult);

        closeBt = (Button) findViewById(R.id.userResultClose);
        confirmBt = (Button) findViewById(R.id.userResultSubmit);


        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss(); closeCallBack.run();
            }
        });

        confirmBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss(); confirmCallBack.run();
            }
        });
    }
}
