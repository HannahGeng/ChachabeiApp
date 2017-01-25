//
//  YearViewController.m
//  企业年报Demo
//
//  Created by zdzx-008 on 16/3/29.
//  Copyright © 2016年 zdzx-008. All rights reserved.
//

#import "YearViewController.h"
#import "reportViewController.h"

@interface YearViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * _imageView;
    UILabel * _label;
    NSString * _timeString;
    MBProgressHUD * mbHud;
}

@property (nonatomic,strong)NSArray * yearArray;

@end

@implementation YearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppShare;
    
    self.navigationItem.title = @"企业年报";
    
    [self getNav];
    
    [self createTableView];
    
    _yearArray = app.yearArr;
}

- (void)getNav
{
    SetNavigationBar(@"企业年报");
    Backbutton;
}

backClick;

- (void)createTableView
{
    UITableView * yearTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];

    yearTable.delegate = self;
    yearTable.dataSource = self;

    [self.view addSubview:yearTable];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _yearArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.text = _yearArray[indexPath.row];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    mbHUDinit;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //六位随机数
    NSString * nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]];
    
    //时间戳
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMddmmss"];
    
    NSString * year = [AESCrypt encrypt:_yearArray[indexPath.row] password:[AESCrypt decrypt:app.loginKeycode]];
    
    _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.loginKeycode]];
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",nonce,@"nonce",_timeString,@"timestamp",[AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]],@"registNo",year,@"year", nil];
    
    [[HTTPSessionManager sharedManager] POST:YEAR_URL parameters:dic result:^(id responseObject, NSError *error) {
        
        app.request = responseObject[@"response"];
        
        hudHide;
    }];

    reportViewController  * vc = [[reportViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
