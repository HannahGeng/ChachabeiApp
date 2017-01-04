//
//  CCBLeftViewController.m
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import "CCBLeftViewController.h"
#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "CCBLeftViewCell.h"

// 取得AppDelegate单利
#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface CCBLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (nonatomic,strong) NSArray * menuArray;

@property (nonatomic,strong) NSArray * controArray;

@end

@implementation CCBLeftViewController

- (NSArray *)menuArray
{
    if (_menuArray == nil) {
        
        _menuArray = @[
                       @{@"image":[UIImage imageNamed:@"app07"],
                         @"text":@"首页"},
                       @{@"image":[UIImage imageNamed:@"app07"],
                         @"text":@"消息盒子"},
                       @{@"image":[UIImage imageNamed:@"app09"],
                         @"text":@"个人中心"},
                       @{@"image":[UIImage imageNamed:@"app10"],
                         @"text":@"我的关注"},
                       @{@"image":[UIImage imageNamed:@"app11"],
                         @"text":@"设置"},
                       ];
    }
    
    return _menuArray;
}

- (NSArray *)controArray
{
    if (_controArray == nil) {
        
        _controArray = @[
                         [[MainViewController alloc] init],
                         [[NewViewController alloc]init],
                         [[PersonalViewController alloc] init],
                         [[AttentionViewController alloc] init],
                         [[SetViewController alloc] init]
                         ];
    }
    
    return _controArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //影藏多余的分割线
    self.leftTableView.tableFooterView=[[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCBLeftViewCell * leftCell = [CCBLeftViewCell cellWithTableView:tableView];
    
    leftCell.imageView.image = self.menuArray[indexPath.row][@"image"];
    leftCell.textLabel.text = self.menuArray[indexPath.row][@"text"];
    
    return leftCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCBNavigationController * nav = [[CCBNavigationController alloc] initWithRootViewController:self.controArray[indexPath.row]];
    
    [self.mm_drawerController
     setCenterViewController:nav
     withCloseAnimation:YES
     completion:nil];
}

- (IBAction)exitClick {
    
    
}

@end
