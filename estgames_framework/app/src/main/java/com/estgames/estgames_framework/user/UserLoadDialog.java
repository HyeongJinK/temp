package com.estgames.estgames_framework.user;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.CustomFunction;


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
            System.out.println("closeCallBack");
        }
    };
    public Runnable confirmCallBack = new Runnable() {
        @Override
        public void run() {
            System.out.println("confirmCallBack");
        }
    };

    public CustomFunction<String, Boolean> confirmCheck = new CustomFunction<String, Boolean>() {
        @Override
        public Boolean apply(String s) {
            if (s.equals("confirm")) {
                return true;
            } else {
                return false;
            }
        }
    };

    public Runnable failConfirmCheck = new Runnable() {
        @Override
        public void run() {
            System.out.println("failConfirmCheck");
        }
    };

    public UserLoadDialog(Context context) {
        super(context);
    }

    public UserLoadDialog(Context context, Runnable confirmCallBack, Runnable closeCallBack) {
        super(context);
        this.confirmCallBack = confirmCallBack;
        this.closeCallBack = closeCallBack;
    }

    public UserLoadDialog(Context context, Runnable confirmCallBack, CustomFunction<String, Boolean> confirmCheck, Runnable closeCallBack) {
        super(context);
        this.confirmCallBack = confirmCallBack;
        this.confirmCheck = confirmCheck;
        this.closeCallBack = closeCallBack;
    }


    public String getEditText() {
        return editText.getText().toString();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("Create-----------");
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
                if (confirmCheck.apply(editText.getText().toString())) {
                    self.dismiss();
                    confirmCallBack.run();
                } else {
                    failConfirmCheck.run();
                }
            }
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        System.out.println("Start-----------");
    }
}
