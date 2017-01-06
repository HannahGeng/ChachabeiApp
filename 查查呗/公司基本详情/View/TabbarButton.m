//
//  TabbarButton.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/5.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "TabbarButton.h"

@implementation TabbarButton

- (NSArray *)dicArray
{
    if (_dicArray == nil) {
        
        _dicArray = @[
                      @{@"img":[UIImage imageNamed:@"app33"],
                        @"selimg":[UIImage imageNamed:@"app33"],
                        @"title":@"评论"},
                      @{@"img":[UIImage imageNamed:@"app34"],
                        @"selimg":[UIImage imageNamed:@"app34"],
                        @"title":@"分享"},
                      @{@"img":[UIImage imageNamed:@"app35"],
                        @"selimg":[UIImage imageNamed:@"guanzhu"],
                        @"title":@"关注"},
                      @{@"img":[UIImage imageNamed:@"app36"],
                        @"selimg":[UIImage imageNamed:@"app36"],
                        @"title":@"发送"},
                      ];
    }
    
    return _dicArray;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整文字
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
   
    self.titleLabel.x = 0;
    self.titleLabel.y = 25;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    //按钮内部图片适配
    self.imageView.size = CGSizeMake(22, 18);
    
    // 调整图片
    self.imageView.centerX = self.titleLabel.centerX;
    self.imageView.y = 5;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
    }
    
    return self;
}

@end
