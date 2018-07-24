package com.estgames.estgames_framework.webview

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Message
import android.provider.MediaStore
import android.text.TextUtils
import android.webkit.ValueCallback
import android.webkit.WebChromeClient
import android.webkit.WebView

class FileUploadWebChromeClient(private val activity: Activity): WebChromeClient() {
    companion object {
        const val REQUEST_FIND_GALLERY = 3003
    }
    private var _fileCallbackUnderLollipop: ValueCallback<Uri>? = null
    private var _fileCallbackOverLollipop: ValueCallback<Array<Uri>>? = null

    override fun onCreateWindow(view: WebView, dialog: Boolean, userGesture: Boolean, resultMsg: Message): Boolean {
        val settings = view.settings
        settings.domStorageEnabled = true
        settings.javaScriptEnabled = true
        settings.allowFileAccess = true
        settings.allowContentAccess = true

        view.webChromeClient = this

        val transport = resultMsg.obj as WebView.WebViewTransport
        transport.webView = view
        resultMsg.sendToTarget()
        return false
    }

    /**
     * Build.VERSION_CODES.ICE_CREAM_SANDWICH <= Build.VERSION.SDK_INT < Build.VERSION_CODES.KITKAT
     */
    fun openFileChooser(uploadMsg: ValueCallback<Uri>, acceptType: String) {
        openFileChooser(uploadMsg, acceptType, "")
    }

    /**
     * Build.VERSION_CODES.KITKAT <= Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP
     */
    fun openFileChooser(uploadFile: ValueCallback<Uri>, acceptType: String, capture: String) {
        _fileCallbackUnderLollipop = uploadFile
        openChooser()
    }

    /**
     * Build.VERSION_CODES.LOLLIPOP <= Build.VERSION.SDK_INT
     */
    override fun onShowFileChooser(
            webView: WebView,
            filePathCallback: ValueCallback<Array<Uri>>,
            fileChooserParams: WebChromeClient.FileChooserParams): Boolean {
        _fileCallbackOverLollipop = filePathCallback
        openChooser()
        return true
    }

    private fun openChooser() {
        val mediaScanIntent = Intent(Intent.ACTION_PICK)
        mediaScanIntent.type = MediaStore.Images.Media.CONTENT_TYPE
        mediaScanIntent.data = MediaStore.Images.Media.EXTERNAL_CONTENT_URI

        activity.startActivityForResult(
                Intent.createChooser(mediaScanIntent, "Image Select"),
                REQUEST_FIND_GALLERY
        )
    }

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == FileUploadWebChromeClient.REQUEST_FIND_GALLERY) {
            if (resultCode == Activity.RESULT_OK) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    if (data == null || TextUtils.isEmpty(data.dataString)) {
                        _fileCallbackOverLollipop?.onReceiveValue(null)
                    } else {
                        _fileCallbackOverLollipop?.onReceiveValue(arrayOf(Uri.parse(data.dataString)))
                    }
                    _fileCallbackOverLollipop = null
                } else {
                    _fileCallbackUnderLollipop?.onReceiveValue(data?.data)
                    _fileCallbackUnderLollipop = null
                }
            } else {
                _fileCallbackOverLollipop?.onReceiveValue(null)
                _fileCallbackUnderLollipop?.onReceiveValue(null)
                _fileCallbackOverLollipop = null
                _fileCallbackUnderLollipop = null
            }
        }
    }
}