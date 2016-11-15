//
//  ContentView.m
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "ContentView.h"

@interface ContentView ()

@end

@implementation ContentView


- (IBAction)standardType:(UIButton *)sender {
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"standard" object:nil userInfo:nil];
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
    
}

- (IBAction)cleverType:(UIButton *)sender {
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"bigger" object:nil userInfo:nil];
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
    
}

- (IBAction)close:(id)sender {
    
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}

@end
