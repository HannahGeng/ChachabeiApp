//
//  reportViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/7.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "reportViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface reportViewController ()

@property (weak, nonatomic) IBOutlet SKSTableView *tableView;
@property (nonatomic,strong)NSArray * contents;

@end

@implementation reportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    return self;
}

- (NSArray *)contents
{
    if (!_contents) {//三组数据,每组都带折叠效果
        _contents =@[@[@"注册号",@"企业经营状态",@"从业人数",@"本年度是否发生股东股权转让",@"企业是否有投资信息或购买其他公司股权"],@[@"企业联系电话",@"电子邮箱"],@[@"企业通讯地址",@"广东省，深圳市"],@[@"股东（发起人）及出资信息",@"张晨",@"刘洪涛",@"玉凯"],@[@"网站或网店信息",@"开心麻花官方网站（网站）"],@[@"对外投资信息",@"北京都市乐人文化发展有限公司",@"开心麻花娱乐传媒有限公司"]];
    }
    
    return _contents;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.SKSTableViewDelegate = self;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0.1;
    self.tableView.rowHeight = 40;
    [self.view addSubview:self.tableView];

    Backbutton;
}

backClick;

#pragma mark - UITableViewDataSource

//共几组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

//每组数据有几行cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 5;
    }else if (section == 1 || section == 2){
        return 2;
    }else{
        return 1;
    }
}

//每组有几行子cell
- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = self.contents[indexPath.section][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    if ((indexPath.section == 3) || (indexPath.section == 4) ||(indexPath.section == 5)) {
        cell.isExpandable = YES;
    }else{
        cell.isExpandable = NO;
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.contents[indexPath.section][indexPath.subRow]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
