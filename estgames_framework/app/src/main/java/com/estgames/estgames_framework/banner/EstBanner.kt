package com.estgames.estgames_framework.banner

import android.app.Dialog
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.widget.ImageView
import java.io.IOException
import java.net.MalformedURLException
import java.net.URL
import java.util.ArrayList
import javax.net.ssl.HttpsURLConnection

/**
 * Created by mp on 2018. 1. 30..
 */
class EstBanner(context: Context) : Dialog(context, android.R.style.Theme_NoTitleBar_Fullscreen) {
//    internal var imageView: ImageView? = null
//    internal var bitmap: ArrayList<Bitmap>
//    //    internal var bannerJson: BannerJson? = null
//    internal var apiService: BannerApiService
//
//
//    init {
//        bitmap = ArrayList()
//        apiService = BannerApiService(context)
//    }
//
//
//    override fun onCreate(savedInstanceState: Bundle) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.estgames_banner)
//        imageView = findViewById(R.id.imageView) as ImageView
//
//        val mThread = object : Thread() {
//            override fun run() {
//                try {
//                    //for (Entry entry: bannerJson.getEntries()) {
//                    //entry.getBanner().getResource();
//
//                    val url = URL("https://s3.ap-northeast-2.amazonaws.com/m-upload.estgames.co.kr/banner/fc9e624f181512005118.3104234.jpg")
//
//                    val conn = url.openConnection() as HttpsURLConnection
//                    conn.doInput = true
//                    conn.connect()
//
//                    val `is` = conn.inputStream
//                    bitmap.add(BitmapFactory.decodeStream(`is`))
//                    //}
//                } catch (e: MalformedURLException) {
//                    e.printStackTrace()
//                } catch (e: IOException) {
//                    e.printStackTrace()
//                }
//
//            }
//        }
//
//        mThread.start()
//
//        try {
//            mThread.join()
//            imageView?.setImageBitmap(bitmap[0])
//        } catch (e: InterruptedException) {
//            e.printStackTrace()
//        }
//
//    }
}
