//
//  BranchViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "BranchViewController.h"

@interface BranchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView * tableView;

@property (nonatomic,strong) NSArray * branchs;

@end

@implementation BranchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadBranchs];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentSize = CGSizeMake(0, screen_height + 35);
    [self.view addSubview:self.tableView];
}

- (void)loadBranchs
{
    AppShare;
    
    NSMutableArray * dicArr = [NSMutableArray array];
    NSArray * stockArr = app.companyDetailContent[@"branchInfo"];
    
    for (NSDictionary * dic in stockArr) {
        
        BranchModel * detail = [[BranchModel alloc] initWithDic:dic];
        
        [dicArr addObject:detail];
    }
    
    self.branchs = dicArr;
    
    app.branchs = dicArr;
    
    //添加内容视图
    [self addContentView];
}

-(void)addContentView
{
    if (self.branchs.count == 0) {
        
        NoneMessage;
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        self.tableView.tableHeaderView=view;
        self.tableView.tableFooterView=[[UIView alloc]init];
        self.tableView.separatorStyle = UITableViewCellSelectionStyleGray;

    }else{
        
        NoneHide;
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.tableView.tableHeaderView=view;
        self.tableView.tableFooterView=[[UIView alloc]init];
        self.tableView.separatorStyle = UITableViewCellSelectionStyleGray;
    }

}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.branchs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BranchViewCell *cell=[BranchViewCell cellWithTableView:self.tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    cell.branch = self.branchs[indexPath.row];
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
