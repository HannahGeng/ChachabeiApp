//
//  SendView.h
//  查查呗
//
//  Created by zdzx-008 on 16/10/9.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendView;

@protocol SendViewDelegate <NSObject>

@optional

- (void)sendMailDidClickSendBtn:(SendView *)send;

- (void)closeViewDidClickCloseBtn:(SendView *)send;

@end

@interface SendView : UIView

@property (nonatomic,weak) id <SendViewDelegate> delegate;

+ (instancetype)sendview;

+ (instancetype)showInPoint:(CGPoint)point;

+ (void)hideInPoint:(CGPoint)point completion:(void(^)())completion;

@end
