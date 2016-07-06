//
//  RegistViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ContentViewController *_contentVC;
    AppDelegate * app;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * companyDetails;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [AppDelegate sharedAppDelegate];
    app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
    
    NSLog(@"\n公司详情数组源：%@",app.basicInfo);
    
    //添加内容视图
    [self addContentView];
    
}

//添加内容视图
-(void)addContentView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
    view.backgroundColor=LIGHT_GREY_COLOR;
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.scrollEnabled =YES; //设置tableview滚动
    self.tableView.separatorStyle = UITableViewCellSelectionStyleBlue;
    self.tableView.tableHeaderView=view;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    app = [AppDelegate sharedAppDelegate];
    if (indexPath.row==0) {
        
        TableViewCell *cell=[TableViewCell cellWithTableView:self.tableView];
   
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.companyDetail =  app.companyModel;
        
        return cell;
    }
    if (indexPath.row==1) {
        RegistViewCell *cell=[RegistViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;

        return cell;
    }
    if (indexPath.row==2) {
        RegistViewCell2 *cell=[RegistViewCell2 cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;
        return cell;
    }
    if (indexPath.row==3) {
        RegistViewCell3 *cell=[RegistViewCell3 cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;

        return cell;
    }
    if (indexPath.row==4) {
        RegistViewCell4 *cell=[RegistViewCell4 cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;
        return cell;
    }
    return nil;
}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 260;
    }else if (indexPath.row == 1){
        return app.companyModel.cellHeight;
    }

    return 80;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
