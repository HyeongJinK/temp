package com.estgames.estgames_framework.webview

import android.app.DialogFragment
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import com.estgames.estgames_framework.R

class WebViewDialog: DialogFragment() {
    companion object {
        private const val ARG_VIEW_TARGET_URL = "com.estgames.framework.web-view-url"

        @JvmStatic fun createDialog(url: String): WebViewDialog {
            return WebViewDialog().apply {
                arguments = Bundle().apply {
                    putString(ARG_VIEW_TARGET_URL, url)
                }
            }
        }
    }

    private val webChromeClient by lazy { FileUploadWebChromeClient(activity) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_FRAME, android.R.style.Theme_NoTitleBar_Fullscreen);
    }

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val url = arguments.getString(ARG_VIEW_TARGET_URL)
        val v = inflater!!.inflate(R.layout.webview, container, false)

        val webView = v.findViewById<WebView>(R.id.webView_View)
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

        v.findViewById<View>(R.id.btn_web_view_close).bringToFront()
        v.findViewById<View>(R.id.btn_web_view_close).setOnClickListener { dismiss() }

        return v
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        webChromeClient.onActivityResult(requestCode, resultCode, data)
    }
}