//
//  CCBBaseViewController.m
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import "CCBBaseViewController.h"

@interface CCBBaseViewController ()

@end

@implementation CCBBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)pushNewViewController:(UIViewController *)newViewController
{
    [self.navigationController pushViewController:newViewController animated:YES];
}

//设置带图片的做导航栏按钮并且回掉方法
- (void)LeftBarButton
{
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"app03"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)click
{
    AppShare;
    [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
