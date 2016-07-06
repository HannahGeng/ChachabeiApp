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
    UIImageView *_imageView;
    UILabel *_label;
    AppDelegate * app;

}
@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (nonatomic,strong) NSArray * memberArray;
@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [AppDelegate sharedAppDelegate];
    _rowIndex = [app.companyIndex integerValue];
    [self loadMemberArray];
    //添加内容视图
    [self addContentView];
}

- (void)loadMemberArray
{
    
    app = [AppDelegate sharedAppDelegate];

    self.memberArray = [memberModel mj_objectArrayWithKeyValuesArray:app.companyDetailContent[@"member"]];
}

//添加内容视图
-(void)addContentView
{
    if (self.memberArray.count == 0) {
        
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
        
        self.memberTableView.dataSource=self;
        self.memberTableView.delegate=self;
        self.memberTableView.backgroundColor=[UIColor clearColor];
        self.memberTableView.scrollEnabled =YES; //设置tableview滚动
        self.memberTableView.tableHeaderView=view;
        self.memberTableView.tableFooterView=[[UIView alloc]init];

    }else {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.memberTableView.dataSource=self;
        self.memberTableView.delegate=self;
        self.memberTableView.backgroundColor=[UIColor clearColor];
        self.memberTableView.scrollEnabled =YES; //设置tableview滚动
        self.memberTableView.tableHeaderView=view;
        self.memberTableView.tableFooterView=[[UIView alloc]init];
        self.memberTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
//        NSLog(@"\nindexpath = %ld",(long)indexPath.row);

    }
    
//    NSLog(@"\nsequence:%@",cell.member.sequence);

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
