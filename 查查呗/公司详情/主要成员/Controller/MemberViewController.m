//
//  MemberViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _rowIndex;
}

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic,strong) NSArray * memberArray;

@end

@implementation MemberViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadMemberArray];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;
    
    _rowIndex = [app.companyIndex integerValue];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentSize = CGSizeMake(0, screen_height + 35);
    [self.view addSubview:self.tableView];

}

- (void)loadMemberArray
{
    AppShare;
        
    NSMutableArray * dicArr = [NSMutableArray array];
    NSMutableArray * nameArr = [NSMutableArray array];

    NSArray * stockArr = app.companyDetailContent[@"stockInfo"];
    
    for (int i = 0; i < stockArr.count; i++) {
        
        NSString * nameStr = stockArr[i][@"stock_name"];
        
        [nameArr addObject:nameStr];
    }
    
    app.nameArr = nameArr;
    
    for (NSDictionary * dic in stockArr) {
        
        memberModel * detail = [[memberModel alloc] initWithDic:dic];
        
        [dicArr addObject:detail];
    }
    
    app.memberArray = dicArr;

    self.memberArray = dicArr;
    
    //添加内容视图
    [self addContentView];

}

//添加内容视图
-(void)addContentView
{
    if (self.memberArray.count == 0) {
        
        NoneMessage;
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        self.tableView.tableHeaderView=view;
        self.tableView.tableFooterView=[[UIView alloc]init];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
    }else {
        
        NoneHide;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.memberArray.count / 2 + self.memberArray.count % 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MemberViewCell *cell=[MemberViewCell cellWithTableView:self.tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //如果是奇数行，去除最后一行偶数列的分割线和头像图标
    if (self.memberArray.count % 2 == 1) {//奇数个
        
        if (indexPath.row == self.memberArray.count / 2 + self.memberArray.count % 2 - 1) {
            
            [cell.line removeFromSuperview];
            [cell.headView removeFromSuperview];
        }
    }
    
    cell.member = self.memberArray[indexPath.row * 2];
    
    if (!(self.memberArray.count % 2 == 1 && indexPath.row == self.memberArray.count / 2 + self.memberArray.count % 2-1)) {
        
        cell.member = self.memberArray[indexPath.row * 2 + 1];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    memberModel * member = self.memberArray[indexPath.row];
    return member.cellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

@end
