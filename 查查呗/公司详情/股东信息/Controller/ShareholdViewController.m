//
//  ShareholdViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ShareholdViewController.h"

@interface ShareholdViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_imageView;
    UILabel *_label;
}

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic,strong) NSArray * shareHolderArray;

@end

@implementation ShareholdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadCompanyArray];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentSize = CGSizeMake(0, screen_height + 35);
    [self.view addSubview:self.tableView];

    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
}

#pragma mark - 加载数组源
- (void)loadCompanyArray
{
    AppShare;
    NSMutableArray * dicArr = [NSMutableArray array];
    NSArray * stockArr = app.companyDetailContent[@"stockInfo"];
    
    for (NSDictionary * dic in stockArr) {
        
        shareholdModel * detail = [[shareholdModel alloc] initWithDic:dic];
        
        [dicArr addObject:detail];
    }
    
    self.shareHolderArray = dicArr;
    
    app.shareHolderArray = dicArr;
    
    //添加内容视图
    [self addContentView];
    
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    //设置导航栏的颜色
    SetNavigationBar(nil);
    
    //为导航栏添加左侧按钮
    Backbutton;
}

-(void)backButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//添加内容视图
-(void)addContentView
{
    if (self.shareHolderArray.count == 0) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        NoneMessage;
        
        self.tableView.tableHeaderView=view;
        self.tableView.tableFooterView=[[UIView alloc]init];

    }else{
        
        NoneHide;
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        self.tableView.tableHeaderView=view;
        self.tableView.tableFooterView=[[UIView alloc]init];
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shareHolderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareholdViewCell *cell=[ShareholdViewCell cellWithTableView:self.tableView];
    cell.sharehold = self.shareHolderArray[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
