package com.estgames.estgames_framework.webview

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.support.v4.content.ContextCompat
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.view.WindowManager
import android.webkit.*
import com.estgames.estgames_framework.R

class WebViewActivity: AppCompatActivity() {
    companion object {
        private const val ARG_WEB_VIEW_URL = "com.estgames.framework.web-view-url"

        @JvmStatic fun open(activity: Activity, url: String) {
            activity.startActivity(Intent(activity, WebViewActivity::class.java).apply {
                putExtra(ARG_WEB_VIEW_URL, url)
            })
        }
    }

    private val webChromeClient by lazy {
        FileUploadWebChromeClient(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.statusBarColor = ContextCompat.getColor(this, R.color.web_view_status)
        }

        window.addFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN)
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)

        val url = intent.getStringExtra(ARG_WEB_VIEW_URL);

        val webView = findViewById<WebView>(R.id.webView_View)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            webView.settings.safeBrowsingEnabled = false
        }
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.webChromeClient = webChromeClient
        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
                return super.shouldOverrideUrlLoading(view, request)
            }
        }

        webView.loadUrl(url)

        findViewById<View>(R.id.btn_web_view_close).setOnClickListener {
            finish()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        webChromeClient.onActivityResult(requestCode, resultCode, data)
    }
}