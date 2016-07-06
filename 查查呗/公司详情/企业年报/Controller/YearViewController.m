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
    AppDelegate * app;
    UIImageView * _imageView;
    UILabel * _label;
}
@property (nonatomic,strong)NSArray * yearArray;

@end

@implementation YearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"企业年报";
    
    [self getNav];
    
    [self createTableView];
    
    _yearArray = [NSArray arrayWithObjects:@"2014",@"2013", nil];
}

- (void)getNav
{
    SetNavigationBar;
    self.navigationItem.title = @"企业年报";
    Backbutton;
}

backClick;

- (void)createTableView
{
    app = [AppDelegate sharedAppDelegate];

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
    app = [AppDelegate sharedAppDelegate];
    
    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
