//
//  ChangeViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *changeTableView;
@property (nonatomic,strong) NSArray * changes;

@end

@implementation ChangeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadChanges];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadChanges];

    //添加内容视图
    [self addContentView];
    
}

- (void)loadChanges
{
    AppShare;
    
    NSMutableArray * dicArr = [NSMutableArray array];
    NSArray * stockArr = app.companyDetailContent[@"changeInfo"];
    
    for (NSDictionary * dic in stockArr) {
        
        changeModel * detail = [[changeModel alloc] initWithDic:dic];
        
        [dicArr addObject:detail];
    }
    
    self.changes = dicArr;
    
    app.changes = dicArr;
    
}

-(void)addContentView
{
    if (self.changes.count == 0) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.changeTableView.tableHeaderView=view;
        self.changeTableView.tableFooterView=[[UIView alloc]init];
        self.changeTableView.separatorStyle = UITableViewCellSelectionStyleGray;
        
    }else{
        
        [NoneView hide];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.changeTableView.tableHeaderView=view;
        self.changeTableView.tableFooterView=[[UIView alloc]init];
        self.changeTableView.separatorStyle = UITableViewCellSelectionStyleGray;
    }
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.changes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int i=(int)indexPath.row+1;

    if (self.changes.count == 0) {
        
        UITableViewCell * cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    
        ChangeViewCell *cell=[ChangeViewCell cellWithTableView:self.changeTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberLabel.text=[NSString stringWithFormat:@"%d",i];
        cell.changemodel = self.changes[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    changeModel * change = self.changes[indexPath.row];
    return change.cellHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.changeTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
