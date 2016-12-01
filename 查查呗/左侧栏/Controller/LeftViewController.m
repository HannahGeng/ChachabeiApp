//
//  LeftViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    //左侧控制器数组
    NSArray *_leftInfoArray;
    //首页控制器
    UINavigationController *_homeViewController;
    //登陆按钮
    UIButton *_loginButton;
    UINavigationController *_navViewController;
    //消息盒子
    UINavigationController *_navNewViewController;
    //个人中心
    UINavigationController *_navPersonalViewController;
    //我的关注
    UINavigationController *_navAttentionViewController;
    //设置
    UINavigationController *_navSetViewController;
    UIImageView *_imageView;
    UILabel *_nameLabel;
}

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@end

@implementation LeftViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.leftTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加内容视图
    [self addContentView];
    //加载数据
    [self loadData];
    
}
//添加内容视图
-(void)addContentView
{
    
    AppShare;
    
    //headView
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [ UIUtils getWindowWidth], 144)];
    headView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background1.png"]];
    [self.leftTableView addSubview:headView];
    
    //游客头像
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(122, 30, 80, 80)];
    _imageView.backgroundColor=[UIColor whiteColor];
    //保持圆形头像
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius=40;
    
    if (app.isLogin == YES) {
        
        NSData *data = [SaveTool objectForKey:@"image"];
        
        if (!data) {
            _imageView.image=[UIImage imageNamed:@"touxiang.png"];
        }else{
            _imageView.image=[UIImage imageWithData:data];
        }
        
        [headView addSubview:_imageView];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(image)name:@"image" object:nil];

    }else{
        _imageView.image = [UIImage imageNamed:@"touxiang"];
        [headView addSubview:_imageView];
    }
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(122, CGRectGetMaxY(_imageView.frame)+5, 80, 30)];
    
    if (app.isLogin == YES) {
   
        _nameLabel.text = [SaveTool objectForKey:@"username"];
        
    }else{
        _nameLabel.text=@"游客";
    }
    _nameLabel.textColor=[UIColor whiteColor];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.font=[UIFont systemFontOfSize:17];
    [headView addSubview:_nameLabel];
    
    self.leftTableView.dataSource=self;
    self.leftTableView.delegate=self;
    self.leftTableView.backgroundColor=[UIColor clearColor];
    self.leftTableView.scrollEnabled =NO; //设置tableview不滚动
    self.leftTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
    self.leftTableView.tableHeaderView=headView;
    
    [self.leftTableView reloadData];

    if (app.isLogin == YES) {
        _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame=CGRectMake(40, 450, [UIUtils getWindowWidth]-120, 50);
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius=5;
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(logoutButton) forControlEvents:UIControlEventTouchUpInside];
        [self.leftTableView addSubview:_loginButton];

    }else{
    _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame=CGRectMake(40, 450, [UIUtils getWindowWidth]-120, 50);
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius=5;
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"denglu.png"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.leftTableView addSubview:_loginButton];
    }
}
//加载数据
- (void)loadData
{
    _leftInfoArray = @[
                       @{@"image":[UIImage imageNamed:@"home.png"],
                         @"text":@"首页"},
                       @{@"image":[UIImage imageNamed:@"app07.png"],
                         @"text":@"消息盒子"},
                       @{@"image":[UIImage imageNamed:@"app09.png"],
                         @"text":@"个人中心"},
                       @{@"image":[UIImage imageNamed:@"app11.png"],
                         @"text":@"我的关注"},
                       @{@"image":[UIImage imageNamed:@"app10.png"],
                         @"text":@"设置"},
                       ];
}
-(void)image
{
    NSData *data = [SaveTool objectForKey:@"image"];
    
    _imageView.image=[UIImage imageWithData:data];
    
    [self.leftTableView reloadData];
}

-(void)loginButton {
    
    AppShare;
    app.isLogin = YES;
    LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
    
}

- (void)logoutButton
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"你确定要退出登录吗？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.delegate = self;
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppShare;
    
    if (buttonIndex == 1) {
        
        app.isLogin = NO;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phonenum"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passnum"];
        
        LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
    
    }
}

//展示相应的controller
- (void)showViewControllerWithIndex:(int)index
{
    switch (index) {
        case 0://首页
        {
            if (!_navViewController) {
                ViewController *newVC = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
                _navViewController = [[UINavigationController alloc] initWithRootViewController:newVC];
                
            }
            [_sideBarMenuVC setRootViewController:_navViewController animated:YES];
        }
            break;
        case 1://消息盒子
        {
            if (!_navNewViewController) {
                NewViewController *personalVC = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
                _navNewViewController = [[UINavigationController alloc] initWithRootViewController:personalVC];
            }
            [_sideBarMenuVC setRootViewController:_navNewViewController animated:YES];
        }
            break;

        case 2://个人中心
        {
            if (!_navPersonalViewController) {
                PersonalViewController *personalVC = [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];
                _navPersonalViewController = [[UINavigationController alloc] initWithRootViewController:personalVC];
            }
            [_sideBarMenuVC setRootViewController:_navPersonalViewController animated:YES];
        }
            break;
        case 3://我的关注
        {
            if (!_navAttentionViewController) {
                AttentionViewController *AttentionVC = [[AttentionViewController alloc] init];
                _navAttentionViewController = [[UINavigationController alloc] initWithRootViewController:AttentionVC];
            }
            [_sideBarMenuVC setRootViewController:_navAttentionViewController animated:YES];
        }
            break;
        case 4://设置
        {
            if (!_navSetViewController) {
                SetViewController *setViewController = [[SetViewController alloc] init];
                _navSetViewController = [[UINavigationController alloc] initWithRootViewController:setViewController];
            }
            [_sideBarMenuVC setRootViewController:_navSetViewController animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"cellIdentifier";
    ContentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[ContentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setContentView:_leftInfoArray[indexPath.row]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    return cell;

}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    //点击后变成原色
    [self.leftTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //展示相应的controller
    if (app.isLogin == YES) {
        [self showViewControllerWithIndex:(int)indexPath.row];
    }else{
        if ((int)indexPath.row == 1 || (int)indexPath.row == 2 || (int)indexPath.row == 3) {
            
            NoLoginWarn;
            
        }else{
            [self showViewControllerWithIndex:(int)indexPath.row];
        }
    }
}

@end
