//
//  AppDelegate.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "AppDelegate.h"

#define VersionKey @"version"

@interface AppDelegate ()
{
    SideBarMenuViewController *_sideBarMenuVC;
    BMKMapManager *_mapManager;
}
@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"Az3V9mEMDnTafhV54RsB1B89" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //友盟分享
    [UMSocialData setAppKey:@"567b956ae0f55a9148002011"];

    //设置窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置电池栏颜色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shouye)
                                                 name:@"homeView" object:nil];
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString * blog = [defau objectForKey:@"first"];
    if ([blog isEqualToString:@"2"]) {
        
        LoginViewController * login = [[LoginViewController alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = navigation;
                
    }else{
        
        //判断下有没有最新的版本号
        //获取用户最新的版本号:info.plist
        NSString * curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        //获取上一次版本号
        NSString * oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];

        if ([curVersion isEqualToString:oldVersion]) {
            //没有最新版本号,进入登录界面
            LoginViewController * login = [[LoginViewController alloc] init];
            UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:login];
            self.window.rootViewController = navigation;
        }else{
        
        GuideViewController *guideVC=[[GuideViewController alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:guideVC];
        self.window.rootViewController=navigation;
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tongzhi)
                                                     name:@"viewController" object:nil];
            
       
        }
    }
    
    return YES;
}

-(void)tongzhi{
    
    LoginViewController * login = [[LoginViewController alloc] init];
    UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = navigation;

}

-(void)shouye{
    
    //初始化_sideBarMenuVC
    UIViewController *viewController = [[UIViewController alloc] init];
    _sideBarMenuVC = [[SideBarMenuViewController alloc] initWithRootViewController:viewController];
    
    //设定_sideBarMenuVC的左侧栏
    LeftViewController *leftViewController= [[LeftViewController alloc] init];
    leftViewController.sideBarMenuVC = _sideBarMenuVC;
    _sideBarMenuVC.leftViewController = leftViewController;
    //leftViewController展示主视图
    [leftViewController showViewControllerWithIndex:0];
    self.window.rootViewController = _sideBarMenuVC;
}

@end
