//
//  MainViewController.m
//  查查呗
//
//  Created by zdzx-008 on 2016/12/20.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (strong, nonatomic) IBOutlet UITableView *viewTableView;

@property (nonatomic,strong) CCBSegmentView * RCSegView;

@property (nonatomic,strong) CCBHotComViewController * hotCom;

@property (nonatomic,strong) CCBAttentViewController * attent;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    AppShare;
    
    app.tabView.hidden = YES;
    
    //添加内容视图
    [self addContentView];
        
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setPageViewController];

}

- (UIView *)setPageViewController;
{
    if (!_RCSegView) {
        
        self.hotCom = [[CCBHotComViewController alloc] init];
        self.attent = [[CCBAttentViewController alloc] init];
        
        NSArray * controllers = @[self.hotCom,self.attent];
        NSArray * titleArray = @[@"热门企业",@"我的关注"];
        
        CCBSegmentView * seg = [[CCBSegmentView alloc] initWithFrame:CGRectMake(0, self.viewTableView.height, screen_width, screen_height - self.viewTableView.height) controllers:controllers titleArray:titleArray ParentController:self lineWidth:screen_width / 2 lineHeight:2. titleHeight:45];
        
        _RCSegView = seg;
        
        [self.view addSubview:_RCSegView];
    }
    
    return _RCSegView;
}

#pragma mark - 添加内容视图
-(void)addContentView
{
    self.viewTableView.separatorStyle =UITableViewCellSelectionStyleGray;
}

#pragma mark － UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        SearchViewCell *cell=[SearchViewCell cellWithTableView:self.viewTableView];
        [cell.searchButton addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if (indexPath.row==1) {
        
        TopButtonViewCell *cell=[TopButtonViewCell cellWithTableView:self.viewTableView];
        [cell.codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.cardButton addTarget:self action:@selector(cardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.recordButton addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    if (indexPath.row==2) {
        
        ButtonViewCell *cell=[ButtonViewCell cellWithTableView:self.viewTableView];
        
        [cell.redianButton addTarget:self action:@selector(redianClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.nearButton addTarget:self action:@selector(nearButton) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.serviceButton addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - 搜索框点击事件
-(void)searchBarClick
{
    SearViewController *searVC=[[SearViewController alloc]initWithNibName:@"SearViewController" bundle:nil];
    [self.navigationController pushViewController:searVC animated:YES];
}

#pragma mark - 二维码按钮
-(void)codeButtonClick
{
    BarcodeViewController *barcodeVC=[[BarcodeViewController alloc]init];
    [self.navigationController pushViewController:barcodeVC animated:YES];
}

- (void)cardButtonClick
{
    MBhud(@"敬请期待");
}

- (void)recordButtonClick
{
    MBhud(@"敬请期待");
}

#pragma mark - “热点点击事件”
- (void)redianClick
{
    MBhud(@"敬请期待");
}

- (void)addButtonClick
{
    MBhud(@"敬请期待");
}

#pragma mark - “附近”点击事件
-(void)nearButton
{
    NearViewController *nearVC=[[NearViewController alloc]initWithNibName:@"NearViewController" bundle:nil];
    [self.navigationController pushViewController:nearVC animated:YES];
}

#pragma mark - “客服”点击事件
-(void)serviceBtnClick
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://4000520856"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 144;
    }
    if (indexPath.row==1){
        return 120;
    }
    if (indexPath.row==2){
        return 80;
    }
    
    return 0;
}

@end
