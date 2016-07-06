//
//  TimerButton.h
//  LandingDemo
//
//  Created by zdzx-008 on 15/8/26.
//  Copyright (c) 2015年 zdzx-008. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimerButton;
typedef NSString* (^DidChangeBlock)(TimerButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(TimerButton *countDownButton,int second);

typedef void (^TouchedDownBlock)(TimerButton *countDownButton,NSInteger tag);

@interface TimerString : NSTimer
@end

@interface TimerButton : UIButton
{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
    TimerButton *_timerButton;
}
//@property(nonatomic,strong)UIColor *changeFontColor;
//@property(nonatomic,strong)UIColor *normalFontColor;
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;

-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;

/**
 *  开始倒计时，此时按钮disable
 *
 *  @param setting 设置
 */
//- (void)startWithSetting:(TimerString *)setting;

@end
