package com.hand.webview;

import android.app.Activity;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.ProgressBar;

import org.apache.cordova.CordovaActivity;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.engine.SystemWebChromeClient;
import org.apache.cordova.engine.SystemWebView;
import org.apache.cordova.engine.SystemWebViewClient;
import org.apache.cordova.engine.SystemWebViewEngine;

/**
 * Created by panx on 2017/2/22.
 */
public class WebViewActivity extends CordovaActivity {
    public static final String URL = "url";
    private SystemWebView webView;

    private String url;
    private DialogLoad dialogLoad;
    private boolean isFirstLoad = true;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        super.onCreate(savedInstanceState);
        WebViewActivityManager.OnCreateActivity(this);
        setContentView(Util.getRS("activity_webview", "layout", this));
        readIntent();
        initView();
        loadUrl(url);
    }

    private void readIntent() {
        url = getIntent().getStringExtra(URL);
    }

    private void initView() {
        webView = (SystemWebView) findViewById(Util.getRS("webview", "id", this));
        dialogLoad = new DialogLoad(this);
    }

    @Override
    protected CordovaWebView makeWebView() {

        webView.getSettings().setJavaScriptEnabled(true);
        webView.clearCache(true);
        webView.clearHistory();
        SystemWebViewEngine webViewEngine = new SystemWebViewEngine(webView);
        webView.setWebViewClient(new SystemWebViewClient(webViewEngine) {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return false;
            }

           @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
               if(isFirstLoad) {
                   dialogLoad.show();
                   isFirstLoad = false;
               }
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                if(dialogLoad.isShowing())
                new Handler(getMainLooper()).postDelayed(new Runnable() {
                    @Override
                    public void run() {
                       dialogLoad.dismiss();
                    }
                },2000);

            }


        });
        return new CordovaWebViewImpl(webViewEngine);
    }

    @Override
    public void finish() {
        Log.e("WebViewActivity", "finish");
        super.finish();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        WebViewActivityManager.OnDestroyActivity(this);
    }

    @Override
    protected void createViews() {
        appView.getView().requestFocusFromTouch();
    }

}
