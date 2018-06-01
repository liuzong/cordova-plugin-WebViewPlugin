打开在线页面的WebView插件，支持在线页面中调用cordova插件，支持android和ios平台

使用方法：
(1)打开在线页面：
   WebViewPlugin.loadWebView(function (data) {
      //成功打开在线页面，回调函数返回的data值为0，关闭在线页面返回值为1，仅ios平台有效
      if (ionic.Platform.isIOS() && data === 1) {
          //to do ....
      }
   }, function () {
      console.log("WebViewPlugin.loadWebView failed");
   }, url);
   注意：对应android平台，关闭在线页面时回调函数不会返回值，如果想在关闭在线页面时做一些处理，
   可以在app.js中监听resume事件，例如：
    $ionicPlatform.ready(function () {
       //关闭在线页面时，android平台会触发resume事件
       if (ionic.Platform.isAndroid()) {
           $ionicPlatform.on("pause", function (event) {
               //to do ...
           });
           $ionicPlatform.on("resume", function (event) {
               //to do ....
           });
       }
    });
(2)关闭在线页面:
  WebViewPlugin.dismissWebView(function () {
      console.log("WebViewPlugin.dismissWebView success");
  }, function () {
      console.log("WebViewPlugin.dismissWebView error");
  }, '');