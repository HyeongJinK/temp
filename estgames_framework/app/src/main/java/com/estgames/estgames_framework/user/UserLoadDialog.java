package com.estgames.estgames_framework.user;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.CustomFunction;
import com.estgames.estgames_framework.common.CustormSupplier;


/**
 * Created by mp on 2018. 4. 3..
 */

public class UserLoadDialog extends Dialog {
    Activity activity;
    Button closeBt;
    EditText editText;
    Button confirmBt;
    TextView userLoadText;

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

    public CustormSupplier<String> userLoadTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLoad_content);
        }
    };

    public UserLoadDialog(Activity activity) {
        super(activity);
        this.activity = activity;
    }

    public String getEditText() {
        return editText.getText().toString();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.userload);

        closeBt = (Button) findViewById(R.id.userLoadCloseBt);
        editText = (EditText) findViewById(R.id.userLoadEditText);
        confirmBt = (Button) findViewById(R.id.userLoadConfirmBt);

        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                UserLoadDialog.super.dismiss();
                closeCallBack.run();
            }
        });

        confirmBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (confirmCheck.apply(editText.getText().toString())) {
                            UserLoadDialog.super.dismiss();
                            confirmCallBack.run();
                        } else {
                            failConfirmCheck.run();
                        }
                    }
                });
            }
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        this.confirmCallBack = confirmCallBack;
        this.confirmCheck = confirmCheck;
        this.closeCallBack = closeCallBack;
        userLoadText = (TextView) findViewById(R.id.userLoadText);
        userLoadText.setText(userLoadTextSupplier.get());
    }
}
