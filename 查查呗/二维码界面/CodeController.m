//
//  CodeController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/28.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "CodeController.h"

@interface CodeController ()
{
    UIWebView *_webView;
    AppDelegate * app;
    MBProgressHUD * mbHud;
}
@end

@implementation CodeController

- (void)viewDidLoad {
    [super viewDidLoad];

    mbHUDinit;
    
    //设置导航栏的颜色
    SetNavigationBar(nil);
    
    //为导航栏添加左侧按钮
    Backbutton;
    
    app = [AppDelegate sharedAppDelegate];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    _webView = [[UIWebView alloc] initWithFrame:bounds];
    
    _webView.scalesPageToFit = YES;
    
    [self.view addSubview:_webView];
    
    NSURL * url = [NSURL URLWithString:app.urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    hudHide;
}

- (void)backButton
{
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"homeView" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
