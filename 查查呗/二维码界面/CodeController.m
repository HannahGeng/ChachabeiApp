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
    MBProgressHUD * mbHud;
}
@end

@implementation CodeController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppShare;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    _webView = [[UIWebView alloc] initWithFrame:bounds];
    
    _webView.scalesPageToFit = YES;
    
    [self.view addSubview:_webView];
    
    NSURL * url = [NSURL URLWithString:app.urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;

    //设置导航栏的颜色
    SetNavigationBar(nil);
    
    //为导航栏添加左侧按钮
    Backbutton;
    
    app.tabView.hidden = YES;
    
}

- (void)backButton
{
    ContentViewController * content = [[ContentViewController alloc] init];
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[content class]]) {
        
        [self.navigationController popViewControllerAnimated:YES];

    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"homeView" object:nil];
    }

}

@end
