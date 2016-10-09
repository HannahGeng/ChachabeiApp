//
//  SendCover.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/9.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "SendCover.h"

@implementation SendCover

+ (void)show
{
    //创建萌版对象
    SendCover * cover = [[SendCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    cover.backgroundColor = [UIColor blackColor];
    
    cover.alpha = 0.6;
    
    //把蒙板添加到主窗口
    [KWindow addSubview:cover];;
}

+ (void)hide
{
    for (UIView * childView in KWindow.subviews) {
        
        if ([childView isKindOfClass:self]) {
            
            [childView removeFromSuperview];
        }
    }
}

@end
