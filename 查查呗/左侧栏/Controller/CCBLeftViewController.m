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

@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (nonatomic,strong) NSArray * menuArray;

@property (nonatomic,strong) NSArray * controArray;

@end

@implementation CCBLeftViewController

- (void)viewWillAppear:(BOOL)animated
{
    AppShare;
    
    [super viewWillAppear:animated];
    
    NSData *data = [SaveTool objectForKey:@"image"];
    if (!data) {
        self.headView.image=[UIImage imageNamed:@"touxiang.png"];
    }else{
        self.headView.image=[UIImage imageWithData:data];
    }
    
    if (app.isLogin) {//登录状态
        
        self.loginButton.hidden = YES;
        
    }else{//为登录状态
        
        self.exitButton.hidden = YES;
    }
    
    if (app.username == NULL) {
        
        self.nickName.text = @"昵称";
        
    }else{
        
        self.nickName.text = app.username;

    }
}

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
    AppShare;
    
    if (indexPath.row == 0 || indexPath.row == 4) {
        
        CCBNavigationController * nav = [[CCBNavigationController alloc] initWithRootViewController:self.controArray[indexPath.row]];
        
        [self.mm_drawerController
         setCenterViewController:nav
         withCloseAnimation:YES
         completion:nil];
        
    }else{
        
        if (app.isLogin) {//登录状态
            
            CCBNavigationController * nav = [[CCBNavigationController alloc] initWithRootViewController:self.controArray[indexPath.row]];
            
            [self.mm_drawerController
             setCenterViewController:nav
             withCloseAnimation:YES
             completion:nil];
            
        }else{//非登录状态
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号登录" message:@"如果想获取更多数据，请先登录" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:naviController animated:YES completion:nil];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
    }
}

//退出按钮
- (IBAction)exitClick {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"你确定要退出登录吗？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phonenum"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passnum"];
        
        LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
        
    }
}

//登录按钮
- (IBAction)loginClick {
    
    LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

@end
