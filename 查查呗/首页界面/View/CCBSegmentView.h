//
//  CCBSegmentView.h
//  查查呗
//
//  Created by zdzx-008 on 2017/1/4.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBSegmentView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray * nameArray;
@property (nonatomic,strong) NSArray * controllers;
@property (nonatomic,strong) UIView * segmentView;
@property (nonatomic,strong) UIScrollView * segmentScrollV;
@property (nonatomic,strong) UILabel * line;
@property (nonatomic,strong) UIButton * seleBtn;
@property (nonatomic,strong) UILabel * down;

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC lineWidth:(float)lineW lineHeight:(float)lineH titleHeight:(NSInteger)height;

@end
