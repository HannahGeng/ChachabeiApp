//
//  NewViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * _uid;
    NSString * _request;
    AFNetworkReachabilityManager * mgr;
    UIImageView *_imageView;
    UILabel *_label;
    MBProgressHUD * mbHud;

}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@property (nonatomic,strong) NSArray * news;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
    [self loadNews];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]];
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"消息盒子");
}

/**
 *  加载消息数据
 */
- (void)loadNews
{
    AppShare;
    
    //request
    _request = app.request;
    
    //uid
    _uid = app.uid;
    
    //参数
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_request,@"request",_uid,@"uid", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:Home_Message parameters:pDic result:^(id responseObject, NSError *error) {
                                
                self.news = [newModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                
                app.request = responseObject[@"response"];
                app.messageArray = responseObject[@"result"];
                [self.messageTableView reloadData];
                
                //添加内容视图
                [self addTableView];

            }];
            
            
        }else{
            
            noWebhud;            
        }
    }];
   
}

//加载tableView
-(void)addTableView{
    
    AppShare;
    
    if ([app.messageArray isEqual:@"暂无新消息"]) {
        
        [self.messageTableView addSubview:[[NoneView showNoneView] showInPoint:self.messageTableView.center title:@"暂无新消息 "]];

//        [[NoneView showNoneView] showInPoint:self.messageTableView.center title:@"暂无新消息"];
        
        self.messageTableView.backgroundColor=[UIColor clearColor];
        self.messageTableView.tableFooterView=[[UIView alloc] init];
        self.messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }else{
        
        self.messageTableView.backgroundColor=[UIColor clearColor];
        self.messageTableView.tableFooterView=[[UIView alloc] init];
        self.messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewViewCell *cell=[NewViewCell cellWithTableView:self.messageTableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.newmodel = self.news[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击后变成原色
    [self.messageTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewContentController *newConteneVC=[[NewContentController alloc]initWithNibName:@"NewContentController" bundle:nil];
    [self.navigationController pushViewController:newConteneVC animated:YES];
}

@end
