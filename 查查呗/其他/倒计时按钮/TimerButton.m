//
//  TimerButton.m
//  LandingDemo
//
//  Created by zdzx-008 on 15/8/26.
//  Copyright (c) 2015年 zdzx-008. All rights reserved.
//

#import "TimerButton.h"

@implementation TimerButton

#pragma -mark touche action
-(void)addToucheHandler:(TouchedDownBlock)touchHandler{
    _touchedDownBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(TimerButton*)sender{
    if (_touchedDownBlock) {
        _touchedDownBlock(sender,sender.tag);
    }
}

#pragma -mark count down method
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}
-(void)timerStart:(NSTimer *)theTimer {
    if (_second == 1)
    {
        [self stop];
    }
    else
    {
        _second--;
        if (_didChangeBlock)
        {
            [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateNormal];
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)stop{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock)
                {
                    [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                }
            }
        }
    }
}

#pragma -mark block
-(void)didChange:(DidChangeBlock)didChangeBlock{
    _didChangeBlock = [didChangeBlock copy];
}
-(void)didFinished:(DidFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

@end
