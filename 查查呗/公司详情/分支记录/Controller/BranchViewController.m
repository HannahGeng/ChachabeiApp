//
//  BranchViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "BranchViewController.h"

@interface BranchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_imageView;
    UILabel *_label;
    AppDelegate * app;
}
@property (weak, nonatomic) IBOutlet UITableView *branchTableView;
@property (nonatomic,strong) NSArray * branchs;

@end

@implementation BranchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBranchs];
    //添加内容视图
    [self addContentView];

}

- (void)loadBranchs
{
    
    app = [AppDelegate sharedAppDelegate];

    self.branchs = [BranchModel mj_objectArrayWithKeyValuesArray:app.companyDetailContent[@"branch"]];
}

-(void)addContentView
{
    if (self.branchs.count == 0) {
        
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
        
        self.branchTableView.dataSource=self;
        self.branchTableView.delegate=self;
        self.branchTableView.backgroundColor=[UIColor clearColor];
        self.branchTableView.scrollEnabled =YES; //设置tableview滚动
        self.branchTableView.tableHeaderView=view;
        self.branchTableView.tableFooterView=[[UIView alloc]init];
        self.branchTableView.separatorStyle = UITableViewCellSelectionStyleGray;

    }else{
    
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.branchTableView.dataSource=self;
        self.branchTableView.delegate=self;
        self.branchTableView.backgroundColor=[UIColor clearColor];
        self.branchTableView.scrollEnabled =YES; //设置tableview滚动
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
