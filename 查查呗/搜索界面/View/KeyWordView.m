//
//  KeyWordView.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/11.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "KeyWordView.h"

@implementation KeyWordView

- (void)didMoveToSuperview
{
    [self.keywordLabel observeValueForKeyPath:@"k" ofObject:self change:nil context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"change:%@",[change valueForKey:@"k"]);
    
}

- (void)didReceiveMemoryWarning {


    [self removeObserver:self forKeyPath:@"num" context:nil];
}

+ (instancetype)show
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)showInPoint:(CGPoint)point
{
    KeyWordView * key = [KeyWordView show];
    
    [KWindow addSubview:key];
    
    key.center = point;
    
    return key;
}

+ (void)hide
{
    
}

@end
