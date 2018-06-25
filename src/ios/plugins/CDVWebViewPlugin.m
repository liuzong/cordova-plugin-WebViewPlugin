//
//  CDVWebViewPlugin.m
//  HelloCordova
//
//  Created by Mr.xiao on 17/2/16.
//
//

#import "CDVWebViewPlugin.h"
#import "WebPluginController.h"

@interface CDVWebViewPlugin ()<WebPluginProtocol>

@property (nonatomic ,strong) WebPluginController *webPluginCtrl;
@property (nonatomic, strong) NSString *callId;

@end

@implementation CDVWebViewPlugin

- (void)loadWebView:(CDVInvokedUrlCommand *)command{

    
    NSString *result = [[command arguments] firstObject];
    self.webPluginCtrl = [[WebPluginController alloc] init];
    self.callId = command.callbackId;
    [[NSUserDefaults standardUserDefaults] setObject:self.callId forKey:@"WebViewPluginid"];
    
    self.webPluginCtrl.startPage = result;
    self.webPluginCtrl.delegate = self;
    self.webPluginCtrl.openDelegate = self.commandDelegate;
    __weak CDVWebViewPlugin *weakSelf = self;

    [self.commandDelegate runInBackground:^{

            dispatch_async(dispatch_get_main_queue(), ^{

                weakSelf.webPluginCtrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [weakSelf.viewController presentViewController:weakSelf.webPluginCtrl animated:YES completion:nil];
            });


    }];
}

- (void)dismissWebView:(CDVInvokedUrlCommand *)command{

    __weak CDVWebViewPlugin *weakSelf = self;

    NSString* callBackId = [[NSUserDefaults standardUserDefaults] objectForKey:@"WebViewPluginid"];
  
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    WebPluginController* ctl = (WebPluginController*)self.viewController;
    [ctl.openDelegate   sendPluginResult:result callbackId:callBackId];
    
    [self.commandDelegate runInBackground:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.viewController dismissViewControllerAnimated:YES completion:nil];
            //CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
           
        });
    }];
 
    [self.commandDelegate sendPluginResult:result callbackId:callBackId];
}

- (void)webViewDidSuccessLoad{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:0];
//    [self.commandDelegate sendPluginResult:result callbackId:self.callId];
}
- (void)webViewDidFailedLoad{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    [self.commandDelegate sendPluginResult:result callbackId:self.callId];
}

@end
