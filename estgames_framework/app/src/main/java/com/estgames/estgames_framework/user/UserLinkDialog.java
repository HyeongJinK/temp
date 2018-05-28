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
import com.estgames.estgames_framework.common.CustormSupplier;


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

    public CustormSupplier<String> userLinkSnsDataTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLink_middelLabel);
        }
    };

    public CustormSupplier<String> userLinkGuestDataTextSupplier = new CustormSupplier<String>() {
        @Override
        public String get() {
            return (String) getContext().getText(R.string.estcommon_userLink_bottomLabel);
        }
    };

//    public UserLinkDialog(Context context) {
//        super(context);
//    }
    public UserLinkDialog(Activity activity) {
        super((Context) activity);
        this.activity = activity;
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
                //getContext().
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dismiss();
                        confirmCallBack.run();
                    }
                });
            }
        });

        cancelBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dismiss();
                        cancelCallBack.run();
                    }
                });
            }
        });

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
    }

    @Override
    protected void onStart() {
        super.onStart();
        this.confirmCallBack = confirmCallBack;
        this.cancelCallBack = cancelCallBack;
        this.closeCallBack = closeCallBack;

        userLinkSnsDataText = (TextView) findViewById(R.id.userLinkSnsDataText);
        userLinkGuestDataText = (TextView) findViewById(R.id.userLinkGuestDataText);
        userLinkSnsDataText.setText(userLinkSnsDataTextSupplier.get());
        userLinkGuestDataText.setText(userLinkGuestDataTextSupplier.get());
    }
}
