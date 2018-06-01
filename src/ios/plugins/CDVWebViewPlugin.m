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
    self.webPluginCtrl.startPage = result;
    self.webPluginCtrl.delegate = self;
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
    
    [self.commandDelegate runInBackground:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.viewController dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:self.callId];
}

- (void)webViewDidSuccessLoad{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:self.callId];
}
- (void)webViewDidFailedLoad{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:self.callId];
}

@end
