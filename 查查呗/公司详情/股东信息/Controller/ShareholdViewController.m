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
    AppDelegate * app;
}

@property (weak, nonatomic) IBOutlet UITableView *ShareholdTableView;

@property (nonatomic,strong) NSArray * shareHolderArray;

@end

@implementation ShareholdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    [self loadCompanyArray];
    //设置导航栏
    [self setNavigationBar];
    //添加内容视图
    [self addContentView];
    
}

#pragma mark - 加载数组源
- (void)loadCompanyArray
{
    app = [AppDelegate sharedAppDelegate];
    self.shareHolderArray = [shareholdModel mj_objectArrayWithKeyValuesArray:app.companyDetailContent[@"stockholder"]];

//    NSLog(@"股东数组:%@",app.companyDetailContent[@"stockholder"]);
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    //设置导航栏的颜色
    SetNavigationBar;
    
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
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-50)/2, 150,50, 50)];
        _imageView.image=[UIImage imageNamed:@"app24.png"];
        [self.view addSubview:_imageView];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-130)/2, CGRectGetMaxY(_imageView.frame)+10, 130, 30)];
        _label.text=@"该企业没有相关信息";
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:_label];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.ShareholdTableView.dataSource=self;
        self.ShareholdTableView.delegate=self;
        self.ShareholdTableView.backgroundColor=[UIColor clearColor];
        self.ShareholdTableView.scrollEnabled =YES; //设置tableview滚动
        self.ShareholdTableView.tableHeaderView=view;
        self.ShareholdTableView.tableFooterView=[[UIView alloc]init];

    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.ShareholdTableView.dataSource=self;
        self.ShareholdTableView.delegate=self;
        
        self.ShareholdTableView.backgroundColor=[UIColor clearColor];
        self.ShareholdTableView.scrollEnabled =YES; //设置tableview滚动
        self.ShareholdTableView.tableHeaderView=view;
        self.ShareholdTableView.tableFooterView=[[UIView alloc]init];
        self.ShareholdTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shareHolderArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareholdViewCell *cell=[ShareholdViewCell cellWithTableView:self.ShareholdTableView];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
    [self.ShareholdTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
