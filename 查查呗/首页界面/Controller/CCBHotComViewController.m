//
//  CCBHotComViewController.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/4.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "CCBHotComViewController.h"

@interface CCBHotComViewController ()

@property (nonatomic,strong) NSArray * hotArray;

@end

@implementation CCBHotComViewController

- (NSArray *)hotArray
{
    AppShare;
    
    if (_hotArray == nil) {
        
        NSMutableArray * dicArr = [NSMutableArray array];
        
        for (NSDictionary * dic in app.hotCompanyArray) {
            
            CompanyDetail * detail = [[CompanyDetail alloc] initWithDictionary:dic];
            
            [dicArr addObject:detail];
            
            _hotArray = dicArr;
        }
    }
    
    return _hotArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView reloadData];
        
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hotArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArrayViewCell *cell = [ArrayViewCell cellWithTable:tableView];
    
    cell.company = self.hotArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;

    //点击后变成原色
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

        if (app.isLogin == YES) {//已登陆用户

            ContentViewController *contentVC=[[ContentViewController alloc]init];

            //公司索引
            app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

            //公司ID
            app.companyID = app.companyArray[indexPath.row][@"eid"];

            app.companyName = app.companyArray[indexPath.row][@"ent_name"];

            [self.navigationController pushViewController:contentVC animated:YES];

        }else{//未登录用户
                
            ContentViewController *contentVC=[[ContentViewController alloc]init];

            app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

            app.companyID = app.companyArray[indexPath.row][@"eid"];
            app.companyName = app.companyArray[indexPath.row][@"ent_name"];
            
            [self.navigationController pushViewController:contentVC animated:YES];
        }

}

@end
