//
//  BranchViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "BranchViewController.h"

@interface BranchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *branchTableView;
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
    
    //添加内容视图
    [self addContentView];

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
}

-(void)addContentView
{
    if (self.branchs.count == 0) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        self.branchTableView.tableHeaderView=view;
        self.branchTableView.tableFooterView=[[UIView alloc]init];
        self.branchTableView.separatorStyle = UITableViewCellSelectionStyleGray;

    }else{
    
        [NoneView hide];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.branchTableView.tableHeaderView=view;
        self.branchTableView.tableFooterView=[[UIView alloc]init];
        self.branchTableView.separatorStyle = UITableViewCellSelectionStyleGray;
    }

}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.branchs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BranchViewCell *cell=[BranchViewCell cellWithTableView:self.branchTableView];
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
    [self.branchTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
