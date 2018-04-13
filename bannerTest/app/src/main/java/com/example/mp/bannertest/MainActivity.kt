package com.example.mp.bannertest

import android.app.Activity
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.Button
import com.estgames.estgames_framework.authority.AuthorityDialog
import com.estgames.estgames_framework.banner.BannerDialog
import com.estgames.estgames_framework.policy.PolicyDialog

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        var test1bt: Button = findViewById(R.id.test1bt);
        var test2bt: Button = findViewById(R.id.test2bt);
        var test3bt: Button = findViewById(R.id.test3bt);

        val test1: AuthorityDialog = AuthorityDialog(this, getSharedPreferences("auth", Activity.MODE_PRIVATE));
        val test2: PolicyDialog = PolicyDialog(this);
        val test3: BannerDialog = BannerDialog(this, getSharedPreferences("banner", Activity.MODE_PRIVATE));

        test1bt.setOnClickListener(View.OnClickListener { test1.show() })
        test2bt.setOnClickListener(View.OnClickListener { test2.show() })
        test3bt.setOnClickListener(View.OnClickListener { test3.show() })

    }
}
