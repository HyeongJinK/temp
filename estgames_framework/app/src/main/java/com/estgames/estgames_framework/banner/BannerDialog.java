package com.estgames.estgames_framework.banner;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;

import com.estgames.estgames_framework.R;
import com.estgames.estgames_framework.common.BannerData;
import com.estgames.estgames_framework.common.Event;
import com.estgames.estgames_framework.common.ResultDataJson;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.net.ssl.HttpsURLConnection;

import static android.R.style.Theme_NoTitleBar_Fullscreen;

/**
 * Created by mp on 2018. 1. 24..
 */

public class BannerDialog extends Dialog {
    ArrayList<Bitmap> bitmap;
    ArrayList<String> urls;
    ArrayList<BannerData> openBanners;
    ResultDataJson bannerJson;
    String bannerApiUrl = "https://dvn2co5qnk.execute-api.ap-northeast-2.amazonaws.com/stage/start/mr";
    Dialog dialog;
    Button linkBt;
    Button closeBt;
    int currentIndex = 0;
    CheckBox oneDayCheck;
    Date todayDate;
    String today;
    SharedPreferences pref;
    SharedPreferences.Editor prefEdit;
    public Runnable callback = new Runnable() {
        @Override
        public void run() {
            System.out.println("class callBack");
        }
    };


    public BannerDialog(Context context, ResultDataJson data, Runnable callback)  {
        super(context, Theme_NoTitleBar_Fullscreen);
        bannerJson = data;
        bitmap = new ArrayList<Bitmap>();
        openBanners = new ArrayList<BannerData>();
        this.pref = context.getSharedPreferences("banner", Activity.MODE_PRIVATE);
        prefEdit = this.pref.edit();
        todayDate = new Date();
        this.callback = callback;

        SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
        today = dt.format(todayDate);
        urls = new ArrayList<String>();

        bannerSetting();
    }

    void bannerSetting() {
        if (bannerJson.getEvents().size() > 0) {

            for (Event entry : bannerJson.getEvents()) {
                if (entry.getBanner() == null || pref.getString(entry.getBanner().getName(), "0").equals(today)) {
                    continue;   //오늘은 더 이상 보지 않기
                }

                bitmap.add(entry.getBanner().getImage());
                openBanners.add(entry.getBanner());
            }
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        dialog = this;

        setContentView(R.layout.banner);
        ImageView imageView = (ImageView)findViewById(R.id.bannerImgView);
        linkBt = (Button) findViewById(R.id.bannerLinkBt);
        closeBt = (Button) findViewById(R.id.bannerCloseBt);
        oneDayCheck = (CheckBox) findViewById(R.id.bannerOneDayCheck);

        imageView.setImageBitmap(bitmap.get(currentIndex));
        linkBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (openBanners.get(currentIndex).getAction().getType().equals("NONE")) {

                } else {
                    //다이얼로그에서 브라우저 열기
                    Uri uri = Uri.parse(openBanners.get(currentIndex).getAction().getUrl());
                    Intent intent = new Intent(Intent.ACTION_VIEW, uri);

                    v.getContext().startActivity(intent);
                }
            }
        });


        closeBt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (oneDayCheck.isChecked()) {  //체크 박스가 true 일 때
                    prefEdit.putString(openBanners.get(currentIndex).getName(), today);
                    prefEdit.commit();
                }

                if(++currentIndex >= bitmap.size()) {   //더 이상 배너 그림이 없으면 닫기
                    callback.run();
                    dialog.dismiss();
                } else {
                    oneDayCheck.setChecked(false);  //이미지 변경하면서 체크 해제
                    imageView.setImageBitmap(bitmap.get(currentIndex));
                }
            }
        });
    }
}

