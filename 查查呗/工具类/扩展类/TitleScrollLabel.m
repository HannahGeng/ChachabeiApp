//
//  TitleScrollLabel.m
//  查查呗
//
//  Created by zdzx-008 on 2016/11/30.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "TitleScrollLabel.h"

@implementation TitleScrollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor grayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // R G B
    // 默认：0.1 0.5 1
    // 红色：1   0   0
    
    CGFloat red = XMGRed + (0.1 - XMGRed) * scale;
    CGFloat green = XMGGreen + (0.5 - XMGGreen) * scale;
    CGFloat blue = XMGBlue + (1 - XMGBlue) * scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
}

@end
