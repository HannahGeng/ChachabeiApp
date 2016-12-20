//
//  UIUtils.m
//  chachabei
//
//  Created by zdzx-008 on 15/11/23.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (CGFloat)getWindowWidth
{
    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.width;
}
+ (CGFloat)getWindowHeight
{
    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.height;
}

@end
