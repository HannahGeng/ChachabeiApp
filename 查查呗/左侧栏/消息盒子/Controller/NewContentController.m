//
//  NewContentController.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "NewContentController.h"

@interface NewContentController ()
{
    UILabel *_titleLabel;
    UILabel *_dataLabel;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
}
@end

@implementation NewContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    //添加内容
    [self addContentView];

}
//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"消息盒子";
    
    //为导航栏添加左侧按钮
    Backbutton;
    
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-35, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
-(void)remindButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
//添加内容
-(void)addContentView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIUtils getWindowWidth], 300)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-300)/2, 20, 300, 30)];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.text=@"免费领取iphone手机啦！";
    _titleLabel.textColor=[UIColor darkGrayColor];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_titleLabel];
    
    _dataLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/2-80, CGRectGetMaxY(_titleLabel.frame), 80, 30)];
    _dataLabel.font=[UIFont systemFontOfSize:14];
    _dataLabel.text=@"2016-1-16";
    _dataLabel.textColor=[UIColor lightGrayColor];
    _dataLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_dataLabel];

    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/2, CGRectGetMaxY(_titleLabel.frame), 40, 30)];
    _timeLabel.font=[UIFont systemFontOfSize:14];
    _timeLabel.text=@"12:00";
    _timeLabel.textColor=[UIColor lightGrayColor];
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:_timeLabel];

    
    NSString * cLabelString=@"       庆祝2016年新年，查呗为大家送大礼！点此免费领取iphone手机。庆祝2016年新年，查呗为大家送大礼！点此免费领取iphone手机。庆祝2016年新年，查呗为大家送大礼！点此免费领取iphone手机。庆祝2016年新年，查呗为大家送大礼！点此免费领取iphone手机。";
    _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_timeLabel.frame)+10, [UIUtils getWindowWidth]-60, 150)];
    _contentLabel.font=[UIFont systemFontOfSize:17];
    _contentLabel.textColor=[UIColor lightGrayColor];
    _contentLabel.numberOfLines=0;
    _contentLabel.textAlignment=NSTextAlignmentLeft;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
    [_contentLabel setAttributedText:attributedString1];
    [_contentLabel sizeToFit];
    
    [view addSubview:_contentLabel];

}

@end
