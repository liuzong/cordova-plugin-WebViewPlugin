//
//  DetailController.h
//  CordBradge-OC
//
//  Created by Mr.xiao on 17/2/14.
//  Copyright © 2017年 keepJion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>

@protocol WebPluginProtocol<NSObject>

- (void)webViewDidSuccessLoad;
- (void)webViewDidFailedLoad;

@end

@interface WebPluginController : CDVViewController

@property (nonatomic ,copy) NSString *fileUrl;
@property (nonatomic, weak) id<WebPluginProtocol> delegate;
@end
