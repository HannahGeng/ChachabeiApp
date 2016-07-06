//
//  ChangeViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_imageView;
    UILabel *_label;
    AppDelegate * app;
}
@property (weak, nonatomic) IBOutlet UITableView *changeTableView;
@property (nonatomic,strong) NSArray * changes;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadChanges];

    //添加内容视图
    [self addContentView];
    
}

- (void)loadChanges
{
    
    app = [AppDelegate sharedAppDelegate];

    self.changes = [changeModel mj_objectArrayWithKeyValuesArray:app.companyDetailContent[@"modify"]];
    
}

-(void)addContentView
{
    if (self.changes.count == 0) {
        
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
        
        self.changeTableView.dataSource=self;
        self.changeTableView.delegate=self;
        self.changeTableView.backgroundColor=[UIColor clearColor];
        self.changeTableView.tableHeaderView=view;
        self.changeTableView.tableFooterView=[[UIView alloc]init];
        self.changeTableView.separatorStyle = UITableViewCellSelectionStyleGray;
        
    }else{
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.changeTableView.dataSource=self;
        self.changeTableView.delegate=self;
        self.changeTableView.backgroundColor=[UIColor clearColor];
        self.changeTableView.scrollEnabled =YES; //设置tableview滚动
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
//
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
