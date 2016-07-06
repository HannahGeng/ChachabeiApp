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
    AppDelegate * app;
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
    SetNavigationBar;
    self.title=@"消息盒子";
    
}

/**
 *  加载消息数据
 */
- (void)loadNews
{
    //request
    app = [AppDelegate sharedAppDelegate];
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
                
//                NSLog(@"消息盒子：%@",responseObject);
                
                self.news = [newModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                
                app = [AppDelegate sharedAppDelegate];
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
    
    app = [AppDelegate sharedAppDelegate];

    if ([app.messageArray isEqual:@"暂无新消息"]) {
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-50)/2, 150,50, 50)];
        _imageView.image=[UIImage imageNamed:@"app24.png"];
        [self.view addSubview:_imageView];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-130)/2, CGRectGetMaxY(_imageView.frame)+10, 130, 30)];
        _label.text=@"暂无新消息";
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:_label];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
        self.messageTableView.dataSource=self;
        self.messageTableView.delegate=self;
        self.messageTableView.scrollEnabled =YES; //设置tableview滚动
        self.messageTableView.backgroundColor=[UIColor clearColor];
        self.messageTableView.tableFooterView=[[UIView alloc] init];
        self.messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }else{
    self.messageTableView.dataSource=self;
    self.messageTableView.delegate=self;
    self.messageTableView.scrollEnabled =YES; //设置tableview滚动
    self.messageTableView.backgroundColor=[UIColor clearColor];
    self.messageTableView.tableFooterView=[[UIView alloc] init];
    self.messageTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
}
#pragma mark UITableViewDataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return self.news.count;
//}
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
