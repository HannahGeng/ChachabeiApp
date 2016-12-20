//
//  UIButton+CCBButton.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/8.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "UIButton+CCBButton.h"

@implementation UIButton (CCBButton)

- (void)buttonWithImage:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)buttonInsets title:(NSString *)title titleEggeInsets:(UIEdgeInsets)titleInsets titleFont:(CGFloat)font
{
    [self setImage:image forState:UIControlStateNormal];
    self.imageEdgeInsets = buttonInsets;
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleEdgeInsets = titleInsets;
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
