//
//  NoneView.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/10.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "NoneView.h"

@interface NoneView ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation NoneView

+ (instancetype)showNoneView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)showInPoint:(CGPoint)point title:(NSString *)title
{    
    self.center = point;
    
    _textLabel.text = title;
    
    [KWindow addSubview:self];

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
