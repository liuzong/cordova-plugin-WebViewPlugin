//
//  MBProgressHUD+XW.m
//  handehrms
//
//  Created by xiaowei on 16/9/20.
//  Copyright © 2016年 xiaowei. All rights reserved.
//

#import "MBProgressHUD+XW.h"

@implementation MBProgressHUD (XW)


+ (void)show:(NSString *)text image:(NSString *)img toView:(UIView *)toView{

    if(toView == nil){
        toView = [[[UIApplication sharedApplication] windows] lastObject];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:toView animated:YES];
        
        //配置
        hub.label.text = text;
        
        
        hub.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
        
        hub.mode = MBProgressHUDModeCustomView;
        hub.animationType = MBProgressHUDAnimationZoomOut;
        
        hub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hub.bezelView.backgroundColor = [UIColor colorWithWhite:.1 alpha:.9];
        hub.label.textColor = [UIColor whiteColor];
        
        hub.removeFromSuperViewOnHide = YES;
        //设置蒙版效果
        //    hub.dimBackground = YES;
        //设置隐藏的时间
        [hub hideAnimated:YES afterDelay:1.2];
    });
}


+ (void)showSuccess:(NSString *)success{
    [self show:success image:@"progress_success" toView:nil];
}

+ (void)showError:(NSString *)error{
    [self show:error image:@"progress_error" toView:nil];
}

+ (void)showSuccess:(NSString *)success view:(UIView *)view{
    [self show:success image:@"progress_success" toView:view];
}

+ (void)showError:(NSString *)error view:(UIView *)view{
    [self show:error image:@"progress_error" toView:view];
}

+ (void)showRequestLoad:(NSString *)text toView:(UIView *)toview{
    if(toview == nil){
        UIViewController *ctrl = [self getTopViewControllerWithCtrl:nil];
        if(ctrl){
            toview = ctrl.presentedViewController ? ctrl.presentedViewController.view : ctrl.view;
        }else{
            NSArray *list = [[UIApplication sharedApplication] windows];
            if(![NSStringFromClass([[list lastObject] class]) isEqualToString:@"UITextEffectsWindow"]){
                for (UIView *v in list) {
                    if([NSStringFromClass([v class]) isEqualToString:@"UITextEffectsWindow"]){
                        toview = v;
                    }
                }
                if(toview == nil){
                    toview = [list lastObject];
                }
            }else{
                toview = [list lastObject];
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toview animated:YES];
        
        // Set the custom view mode to show any view.
        hud.mode = MBProgressHUDModeCustomView;
        NSMutableArray *animationList = [NSMutableArray array];
        for (NSInteger i=0; i<16; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"hly_%ld",i]];
            [animationList addObject:image];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imgView.animationImages = animationList;
        imgView.animationDuration = 2.0;
        [imgView startAnimating];
        hud.customView = imgView;
//        hud.offset = CGPointMake(0, -64);
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor clearColor];
        if(text){
            hud.backgroundColor = [UIColor clearColor];
        }else{
            hud.backgroundColor = [UIColor whiteColor];
        }
        hud.animationType = MBProgressHUDAnimationZoom;
        
        [hud setRemoveFromSuperViewOnHide:YES];
    });
}

//获取当前显示的控制器
+ (UIViewController *)getTopViewControllerWithCtrl:(UIViewController *)vc{
    UIViewController *current;
    if(vc == nil){
        vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    if([vc isKindOfClass:[UITabBarController class]]){
        return  [self getTopViewControllerWithCtrl:[(UITabBarController *)vc selectedViewController]];
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        return [self getTopViewControllerWithCtrl:[(UINavigationController *)vc visibleViewController]];
    }else{
        current = vc;
    }
    return current;
}

+ (void)showNoOffset:(NSString *)text toView:(UIView *)toview{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toview animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    NSMutableArray *animationList = [NSMutableArray array];
    for (NSInteger i=0; i<47; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"custom_000%02ld",i+1]];
        [animationList addObject:image];
    }
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.animationImages = animationList;
    imgView.animationDuration = 0.8;
    [imgView startAnimating];
    hud.customView = imgView;
//    hud.customView.layer.cornerRadius = 25;
//    hud.customView.layer.masksToBounds = YES;
    hud.offset = CGPointMake(0, -64);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor whiteColor];
    hud.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    hud.animationType = MBProgressHUDAnimationZoomIn;
    //    [hud hideAnimated:YES afterDelay:5.f];
    [hud setRemoveFromSuperViewOnHide:YES];
}

+ (void)showInterminateWithView:(UIView *)view{
    if(view == nil){
        view = [[[UIApplication sharedApplication]windows] lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
}


+ (void)hideRequestLoad:(UIView *)view{
    if(view == nil){
        UIViewController *ctrl = [self getTopViewControllerWithCtrl:nil];
        if(ctrl){
            view = ctrl.presentedViewController ? ctrl.presentedViewController.view : ctrl.view;
        }else{
            NSArray *list = [[UIApplication sharedApplication] windows];
            if(![NSStringFromClass([[list lastObject] class]) isEqualToString:@"UITextEffectsWindow"]){
                for (UIView *v in list) {
                    if([NSStringFromClass([v class]) isEqualToString:@"UITextEffectsWindow"]){
                        view = v;
                    }
                }
                if(view == nil){
                    view = [list lastObject];
                }
            }else{
                view = [list lastObject];
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

+ (void)customShowLoading:(UIView *)view {
    if(view == nil){
        UIViewController *ctrl = [self getTopViewControllerWithCtrl:nil];
        if(ctrl){
            view = ctrl.presentedViewController ? ctrl.presentedViewController.view : ctrl.view;
        }else{
            NSArray *list = [[UIApplication sharedApplication] windows];
            if(![NSStringFromClass([[list lastObject] class]) isEqualToString:@"UITextEffectsWindow"]){
                for (UIView *v in list) {
                    if([NSStringFromClass([v class]) isEqualToString:@"UITextEffectsWindow"]){
                        view = v;
                    }
                }
                if(view == nil){
                    view = [list lastObject];
                }
            }else{
                view = [list lastObject];
            }
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    NSMutableArray *animationList = [NSMutableArray array];
    for (NSInteger i=0; i<47; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"custom_000%02ld",i+1]];
        [animationList addObject:image];
    }
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.animationImages = animationList;
    imgView.animationDuration = 0.8;
    [imgView startAnimating];
    hud.customView = imgView;
    hud.offset = CGPointMake(0, -64);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor whiteColor];
    
    hud.animationType = MBProgressHUDAnimationZoom;
    
    [hud setRemoveFromSuperViewOnHide:YES];
}


@end
