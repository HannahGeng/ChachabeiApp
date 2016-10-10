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

@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
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
    
    //添加内容视图
    [self addContentView];
    
}

- (void)loadMemberArray
{
    AppShare;
    NSMutableArray * dicArr = [NSMutableArray array];
    NSArray * stockArr = app.basicInfo[@"stockInfo"];
    
    for (NSDictionary * dic in stockArr) {
        
        memberModel * detail = [[memberModel alloc] initWithDic:dic];
        
        [dicArr addObject:detail];
    }
    
    self.memberArray = dicArr;
    
    app.memberArray = dicArr;

}

//添加内容视图
-(void)addContentView
{
    if (self.memberArray.count == 0) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        self.memberTableView.tableHeaderView=view;
        self.memberTableView.tableFooterView=[[UIView alloc]init];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
    }else {
        
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
    
    MemberViewCell *cell=[MemberViewCell cellWithTableView:self.memberTableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //如果是技术行，去除最后一行偶数列的分割线和头像图标
    if (self.memberArray.count % 2 == 1) {//    奇数个
        
        if (indexPath.row == self.memberArray.count / 2 + self.memberArray.count % 2 - 1) {
            [cell.line removeFromSuperview];
            [cell.headView removeFromSuperview];

        }
    }
    
    cell.member = self.memberArray[indexPath.row * 2];
    
    if (!(self.memberArray.count % 2==1 && indexPath.row == self.memberArray.count / 2 + self.memberArray.count % 2-1)) {
        
        cell.member = self.memberArray[indexPath.row * 2+1];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.memberTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
