//
//  GuideTool.m
//  查查呗
//
//  Created by zdzx-008 on 2016/10/19.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "GuideTool.h"
#define VersionKey @"version"

@implementation GuideTool

+ (UIViewController *)chooseRootViewController
{
    //判断下有没有最新的版本号
    //获取用户最新的版本号:info.plist
    NSString * curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //获取上一次版本号
    NSString * oldVersion = [SaveTool objectForKey:VersionKey];
    
    UIViewController *rootVc = nil;
    
    if ([curVersion isEqualToString:oldVersion]) {
        
        //没有最新版本号,进入登录界面
        LoginViewController * login = [[LoginViewController alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:login];
        rootVc = navigation;
        
    }else{
        
        GuideViewController *guideVC=[[GuideViewController alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:guideVC];
        
        rootVc = navigation;
        
        [SaveTool setObject:curVersion forKey:VersionKey];
        
    }
    
    return rootVc;
}

@end
