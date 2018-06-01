//
//  DetailController.m
//  CordBradge-OC
//
//  Created by Mr.xiao on 17/2/14.
//  Copyright © 2017年 keepJion. All rights reserved.
//

#import "WebPluginController.h"
#import "CDVSplashScreen.h"
#import "MBProgressHUD+XW.h"
@interface WebPluginController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILabel *titleLalel;
@property (nonatomic,strong) UIWebView *baseView;
@end

@implementation WebPluginController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLunch:) name:CDVPageDidLoadNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStart:) name:CDVPluginResetNotification object:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [MBProgressHUD showRequestLoad:nil toView:self.view];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) );
    self.webView.backgroundColor = [UIColor whiteColor];
    if(@available(iOS 11.0,*)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

//MARK: ACTION
- (void)didLunch:(NSNotification *)not{
    [MBProgressHUD hideRequestLoad:self.view];
    if([self.delegate respondsToSelector:@selector(webViewDidSuccessLoad)]){
        [self.delegate webViewDidSuccessLoad];
    }
}

- (void)didStart:(NSNotification *)not{
    
}


/*
 重写CDVViewController方法，这样就可以根据自己的需要加载插件了
 这里是不加载 CDVSplashScreen 这个插件
 */

- (void)registerPlugin:(CDVPlugin*)plugin withClassName:(NSString*)className
{
    if([className isEqualToString:@"CDVSplashScreen"]){
        return;
    }
    [super registerPlugin:plugin withClassName:className];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
