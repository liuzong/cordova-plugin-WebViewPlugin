//
//  MBProgressHUD+XW.h
//  handehrms
//
//  Created by xiaowei on 16/9/20.
//  Copyright © 2016年 xiaowei. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XW)


+ (void)showSuccess:(NSString *)success view:(UIView *)view;
+ (void)showError:(NSString *)error view:(UIView *)view;
+ (void)showError:(NSString *)error;
+ (void)showSuccess:(NSString *)success;

+ (void)showRequestLoad:(NSString *)text toView:(UIView *)toview;
+ (void)hideRequestLoad:(UIView *)view;

+ (void)showInterminateWithView:(UIView *)view;

+ (void)showNoOffset:(NSString *)text toView:(UIView *)toview;

+ (void)customShowLoading:(UIView *)view;

@end
