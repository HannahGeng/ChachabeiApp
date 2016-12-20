//
//  AppDelegate.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
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
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor redColor];
    
    self.window.rootViewController = [GuideTool chooseRootViewController];
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shouye)
                                                 name:@"homeView" object:nil];
    
    return YES;
}

-(void)shouye{
    
    SHOUYE;
}

@end
