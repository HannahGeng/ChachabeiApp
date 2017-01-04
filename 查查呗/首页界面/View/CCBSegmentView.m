//
//  CCBSegmentView.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/4.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "CCBSegmentView.h"

@implementation CCBSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC lineWidth:(float)lineW lineHeight:(float)lineH titleHeight:(NSInteger)height
{
    if (self = [super initWithFrame:frame]) {
        
        float avgWidth = (frame.size.width/controllers.count);
        self.controllers = controllers;
        self.nameArray = titleArray;
        
        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
        self.segmentView.tag = 50;
        [self addSubview:self.segmentView];
        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height, frame.size.width, frame.size.height)];
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width * self.controllers.count, 0);
        self.segmentScrollV.delegate= self;
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = NO;
        [self addSubview:self.segmentScrollV];
        
        //两个控制器间的切换
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIViewController * con = self.controllers[i];
            [self.segmentScrollV addSubview:con.view];
            con.view.frame = CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height);
            
            [parentC addChildViewController:con];
            [con didMoveToParentViewController:parentC];
        }
        
        //segment按钮颜色切换
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, height);
            btn.tag = i;
            [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:LIGHT_BLUE_COLOR forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:14.];

            [self.segmentView addSubview:btn];
            
            //默认点击了第一个按钮
            if (i == 0) {
                
                btn.enabled = YES;
                self.seleBtn = btn;
                self.seleBtn.selected = YES;
            }
        }
        
        UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, height - lineH + 1, screen_width, 1)];
        lineV.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0f];
        [self.segmentView addSubview:lineV];
        
        self.line = [[UILabel alloc] initWithFrame:CGRectMake((avgWidth-lineW)/2,height-lineH, lineW, lineH)];
        self.line.backgroundColor = LIGHT_BLUE_COLOR;
        self.line.tag = 100;
        [self.segmentView addSubview:self.line];
    }
    
    return self;
}

- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:14.];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}

@end
