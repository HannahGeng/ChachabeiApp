//
//  CCBAttentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/4.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "CCBAttentViewController.h"

@interface CCBAttentViewController ()
{
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (nonatomic,strong) NSArray * attentArray;

@end

@implementation CCBAttentViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadAttantion];

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);

}

- (void)loadAttantion
{
    AppShare;
    
    //封装POST参数
    if (app.isLogin == YES) {
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request", nil];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                //发送POST请求
                [[HTTPSessionManager sharedManager] POST:Personal_attention_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    app.request = responseObject[@"response"];
                    app.attentionArray = responseObject[@"result"];
                                        
                    self.attentArray = [attentionModel mj_objectArrayWithKeyValuesArray:app.attentionArray];
                    
                    if ([app.attentionArray isEqual:@"暂无关注企业"]) {
                        
                        [self.tableView reloadData];
                        
                        [self.tableView addSubview:[[NoneView showNoneView] showInPoint:CGPointMake(screen_width / 2, screen_height / 2 - 200) title:@"暂无信息"]];
                        
                        self.tableView.tableFooterView=[[UIView alloc]init];
                        
                    }else{
                        
                        NoneHide;
                        
                        [self.tableView reloadData];
                        
                    }

                }];
                
            }else{
                
                noWebhud;
            }
        }];
        
    }else{//未登陆
        
        [self.tableView addSubview:[[NoneView showNoneView] showInPoint:CGPointMake(screen_width / 2, screen_height / 2 - 200) title:@"登陆后可查看"]];
        
        self.tableView.tableFooterView=[[UIView alloc]init];

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.attentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArrayViewCell *cell = [ArrayViewCell cellWithTable:tableView];
    
    cell.attention = self.attentArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    //公司索引
    app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    //公司ID
    for (int i = 0; i < app.companyArray.count; i++) {
        
        if ([app.attentionArray[indexPath.row][@"cname"] isEqualToString:app.companyArray[i][@"ent_name"]]) {
            
            app.companyID = app.companyArray[i][@"eid"];
        }
    }
    
    ContentViewController *contentVC=[[ContentViewController alloc]init];
    
    app.companyName = app.attentionArray[indexPath.row][@"cname"];

    [self.navigationController pushViewController:contentVC animated:YES];

}

@end
