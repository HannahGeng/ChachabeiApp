//
//  HotNewsViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/3/22.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "HotNewsViewController.h"

@interface HotNewsViewController ()

@end

@implementation HotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBar];
    
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"热点";
    
    //为导航栏添加左侧按钮
    Backbutton;
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
