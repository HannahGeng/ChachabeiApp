//
//  CCBNewsViewController.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/12.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "CCBNewsViewController.h"

@interface CCBNewsViewController ()

@property (nonatomic,strong) NSArray * news;

@end

@implementation CCBNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SetNavigationBar(@"今日热点");
    Backbutton;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotNewsViewCell class]) bundle:nil] forCellReuseIdentifier:@"hotnews"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadNews];
    
}

- (void)loadNews
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"key"] = @"188cc9e531cdc3f0721c390cc1336153";
    params[@"type"] = @"caijing";
    
    AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
    
    [man GET:@"http://v.juhe.cn/toutiao/index" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        self.news = [HotNewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
    }];

}

- (void)backButton
{
    [self popoverPresentationController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotNewsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"hotnews"];
    
    cell.hotNews = self.news[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
