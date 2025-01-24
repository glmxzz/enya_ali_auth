package com.example.enya_ali_auth.activity

import android.app.Activity
import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import com.example.enya_ali_auth.R

class WebActivity:Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.web_layout)
        val url = intent.getStringExtra("url")
        
        val webView = findViewById<WebView>(R.id.web_view)
        // 配置 WebView 设置
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            useWideViewPort = true
            loadWithOverviewMode = true
        }
        
        // 设置 WebViewClient 确保在应用内加载
        webView.webViewClient = WebViewClient()
        
        if (!url.isNullOrEmpty()) {
            webView.loadUrl(url)
        }
    }
}