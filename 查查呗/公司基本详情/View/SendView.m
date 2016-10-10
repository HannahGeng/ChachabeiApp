//
//  SendView.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/9.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "SendView.h"

@interface SendView ()

@property (weak, nonatomic) IBOutlet UITextField *sendField;

@end

@implementation SendView

- (IBAction)closeButton:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(closeViewDidClickCloseBtn:)]) {
        
        [_delegate closeViewDidClickCloseBtn:self];
    }
}

- (IBAction)sendClick:(UIButton *)sender {

    AppShare;

    app.sendEmail = _sendField.text;

    if ([_delegate respondsToSelector:@selector(sendMailDidClickSendBtn:)]) {
    
        [_delegate sendMailDidClickSendBtn:self];
        
    }
}

+ (instancetype)showInPoint:(CGPoint)point
{
    SendView * send = [SendView sendview];
    
    send.center = point;
    
    [KWindow addSubview:send];
    
    return send;
}

+ (instancetype)sendview
{
    return [[NSBundle mainBundle] loadNibNamed:@"SendView" owner:nil options:nil][0];
}

//隐藏菜单
+ (void)hideInPoint:(CGPoint)point completion:(void(^)())completion
{
    void(^completion1)() = ^{
      
        if (completion) {
            
            completion();
        }
    };
    
    for (SendView * childView in KWindow.subviews) {
        
        if ([childView isKindOfClass:self]) {
            
            [childView setUpHideAnim:point completion:completion];
        }
    }
}

#pragma mark - 隐藏动画
- (void)setUpHideAnim:(CGPoint)point completion:(void (^)())completion
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        transform = CGAffineTransformTranslate(transform, 0, [UIScreen mainScreen].bounds.size.height);
        
        self.transform = transform;
        
    } completion:^(BOOL finished) {
        
        //动画完成的时候，也需要告诉外界
        if (completion) {
            
            completion();
        }
    }];
}

@end
