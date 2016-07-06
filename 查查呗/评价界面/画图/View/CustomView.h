//
//  CustomView.h
//  查查呗
//
//  Created by zdzx-008 on 15/12/2.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomView : UIView

- (id)initWithFrame:(CGRect)frame valueDictionary:(NSDictionary *)valueDictionary;

@property (nonatomic, assign) CGFloat valueDivider;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, strong) UIColor *drawboardColor;
@property (nonatomic, strong) UIColor *plotColor;//阴影的颜色

-(void)animateWithDuration:(NSTimeInterval)duration valueDictionary:(NSDictionary *)valueDictionary;

@end
