//
//  CCBTabBarView.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/5.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "CCBTabBarView.h"

@interface CCBTabBarView ()

@property (nonatomic,strong) TabbarButton * button;

@end

@implementation CCBTabBarView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    AppShare;
    
    self.backgroundColor = LIGHT_BLUE_COLOR;
        
    CGFloat width = self.width;
    CGFloat height = self.height;
    CGFloat buttonW = width / 4;
    CGFloat buttonY = 0;
    CGFloat buttonH = height;

    for (NSInteger i = 0; i < 4; i++) {
        
        self.button = [TabbarButton buttonWithType:UIButtonTypeCustom];

        self.button.tag = i + 1;

        NSArray * arr = self.button.dicArray;
        
        CGFloat buttonX = i * buttonW;
        
        self.button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
         
        [self.button setImage:arr[i][@"img"] forState:UIControlStateNormal];
        
        [self.button setImage:arr[i][@"selimg"] forState:UIControlStateSelected];
        
        [self.button setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.button];
    }
    
}

- (void)buttonClick:(UIButton *)sender
{
    AppShare;
    
    switch (sender.tag) {
        case 1:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"comment" object:self];
            
            break;
            
        case 2:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"share" object:self];
            break;
            
        case 3:
            
            app.isFocus = !sender.selected;
            sender.selected = !sender.selected;
                    
            [[NSNotificationCenter defaultCenter] postNotificationName:@"attent" object:self];
                        
            break;
            
        case 4:
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"send" object:self];
            
            break;
            
        default:
            break;
    }
}

@end
