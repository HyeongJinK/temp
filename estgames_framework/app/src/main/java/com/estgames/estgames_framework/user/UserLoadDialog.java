package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.estgames.estgames_framework.R;

/**
 * Created by mp on 2018. 4. 3..
 */

public class UserLoadDialog extends Dialog {
    Dialog self;
    Button closeBt;
    EditText editText;
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
    public Runnable confirmInputError = new Runnable() {
        @Override
        public void run() {

        }
    };

    public UserLoadDialog(Context context) {
        super(context);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        self = this;
        setContentView(R.layout.userload);

        closeBt = (Button) findViewById(R.id.userLoadCloseBt);
        editText = (EditText) findViewById(R.id.userLoadEditText);
        confirmBt = (Button) findViewById(R.id.userLoadConfirmBt);


        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                self.dismiss();
                closeCallBack.run();
            }
        });

        confirmBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (editText.getText().equals("confirm")) {
                    self.dismiss();
                    confirmCallBack.run();
                } else {
                    confirmInputError.run();
                }
            }
        });
    }
}
