//
//  ViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SegmentViewCell *_cell;
    NSDictionary *_dic;
    NSString *_timeString;
    NSString *_str;
    NSString *_searKey;
    NSString *_strrr;
    NSString *_srr;
    NSString *_key;
    NSString * _uid;
    NSString * _request;
    NSString * _request1;
    NSString * _attentionRequest;
    NSString * _index;
    NSString * _company_no;
    NSString * _imei;
    NSString * _nonce;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
    NoneView * noneV;
}

@property (weak, nonatomic) IBOutlet UITableView *viewTableView;
@property (weak, nonatomic) IBOutlet UITableView *companyTableView;
@property (nonatomic,strong) NSMutableArray * companyArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
        
    //导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
    
    //添加数据(热门企业)
    [self loadHotCompany];
    
    [self loadAttentionCompany];

}

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    
    SetNavigationBar(@"首页");
}

#pragma mark - 添加内容视图
-(void)addContentView
{
    self.viewTableView.separatorStyle = UITableViewCellSelectionStyleGray;
    
    if (_cell.CompanyButton.selected == YES) {
        
        self.viewTableView.bounces = YES;
        
    }else{
        
        self.viewTableView.bounces = NO;
    }
}

#pragma mark - 加载”热门企业“数据
- (void)loadHotCompany
{
    AppShare;
    
    NSMutableArray * hotArr = [NSMutableArray array];
    
    for (NSDictionary * dic in app.companyArray) {
        
        CompanyDetail * company = [[CompanyDetail alloc] initWithDictionary:dic];
        
        [hotArr addObject:company];
    }
    
    self.companyArray = hotArr;
    
    [self.companyTableView reloadData];
    
}

#pragma mark - 加载“我的关注“数据
- (void)loadAttentionCompany
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
                    
                }];
                
            }else{
                
                noWebhud;
                
            }
        }];
        
    }else{//未登陆
        
        self.companyArray = [attentionModel mj_objectArrayWithKeyValuesArray:nil];
    }
 
}

#pragma mark － UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断tableView是上面的还是下面的
    if (tableView == self.viewTableView) {
        
        return 4;
        
    }else{
        
        return self.companyArray.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppShare;
    if (tableView == self.viewTableView) {
        
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
        if (indexPath.row==3) {
            
            _cell=[SegmentViewCell cellWithTableView:self.viewTableView];
            _cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            _cell.CompanyButton.selected=YES;
            _cell.CompanyButton.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
            [_cell.CompanyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_cell.CompanyButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateSelected];
            [_cell.CompanyButton addTarget:self action:@selector(companyClick) forControlEvents:UIControlEventTouchUpInside];
            
            _cell.FocusButton.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
            [_cell.FocusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_cell.FocusButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateSelected];
            
            if (_cell.FocusButton.selected == NO) {
                
                [_cell.FocusButton addTarget:self action:@selector(focusClick) forControlEvents:UIControlEventTouchUpInside];
            }
            _cell.LineIamgeView.backgroundColor=LIGHT_BLUE_COLOR;
            return _cell;
        }

    }else{
        
        if (_cell.CompanyButton.selected == YES) {
            
            ArrayViewCell *cell=[ArrayViewCell cellWithTable:tableView];

            cell.company = self.companyArray[indexPath.row];
            
            return cell;
            
        }else{
            
            if ([app.attentionArray isEqual:@"暂无关注企业"]) {
                
                UITableViewCell *cell=[[UITableViewCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                
                ArrayViewCell *cell=[ArrayViewCell cellWithTable:tableView];
                cell.attention = self.companyArray[indexPath.row];
                
                return cell;
                
            }
        }
        
    }
    
        return nil;
}

#pragma mark - 搜索框点击事件
-(void)searchBarClick
{
    SearViewController *searVC=[[SearViewController alloc]initWithNibName:@"SearViewController" bundle:nil];
    [self.navigationController pushViewController:searVC animated:YES];
}

#pragma mark - “热门企业”按钮
-(void)companyClick
{
    [NoneView hide];
    
    _cell.FocusButton.selected=NO;
    
    if ([_cell.CompanyButton isSelected]) {
        _cell.CompanyButton.selected=YES;
    }else{
        _cell.CompanyButton.selected=YES;
    }
    
    _cell.LineIamgeView.frame=CGRectMake(0, 48, [UIUtils getWindowWidth]/2, 3);
    self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    [self loadHotCompany];
}

#pragma mark - “我的关注”按钮
-(void)focusClick
{
    AppShare;

    if (app.isLogin == YES) {//已登陆用户
        
        if ([app.attentionArray isEqual:@"暂无关注企业"]) {
            
            if (_cell.FocusButton.isSelected == NO) {
                
                self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                
                [[NoneView showNoneView] showInPoint:self.companyTableView.center title:@"暂无关注企业"];
                
                [self.companyTableView reloadData];
            }
            
        }else{
        
            self.companyArray =  [attentionModel mj_objectArrayWithKeyValuesArray:app.attentionArray];
            [self.companyTableView reloadData];
        }
        
    }else{//未登录用户
        
        if (_cell.FocusButton.isSelected == NO) {
            
            self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self loadAttentionCompany];
    
            [[NoneView showNoneView] showInPoint:self.companyTableView.center title:@"登陆后可查看"];
            
            [self.companyTableView reloadData];

        }
       
    }
    
    _cell.CompanyButton.selected=NO;
    _cell.FocusButton.selected=YES;
    
    _cell.LineIamgeView.frame=CGRectMake([UIUtils getWindowWidth]/2, 48, [UIUtils getWindowWidth]/2, 3);
    
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
    if (tableView == self.viewTableView) {
         if (indexPath.row==0) {
             return 80;
         }
        if (indexPath.row==1){
             return 120;
        }
        if (indexPath.row==2){
             return 80;
        }
             return 50;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    //点击后变成原色
    [self.viewTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.companyTableView) {
        
        if (app.isLogin == YES) {//已登陆用户
            
            ContentViewController *contentVC=[[ContentViewController alloc]init];
            
            if (_cell.CompanyButton.selected == YES) {
                
                //公司索引
                app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                
                //公司ID
                app.companyID = app.companyArray[indexPath.row][@"eid"];
                
                app.companyName = app.companyArray[indexPath.row][@"ent_name"];
                
                [self.navigationController pushViewController:contentVC animated:YES];

            }else{//我的关注
                
                    if ([app.attentionArray isEqual:@"暂无关注企业"]) {
                    
                }else{
                    
                    //公司索引
                    app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    
                    //公司ID
                    for (int i = 0; i < app.companyArray.count; i++) {
                        
                        if ([app.attentionArray[indexPath.row][@"cname"] isEqualToString:app.companyArray[i][@"ent_name"]]) {
                            
                            app.companyID = app.companyArray[i][@"eid"];
                        }
                    }
                    
                    app.companyName = app.attentionArray[indexPath.row][@"cname"];

                    [self.navigationController pushViewController:contentVC animated:YES];

                }
                
            }
            
        }else//未登陆用户
        {
            ContentViewController *contentVC=[[ContentViewController alloc]init];
            
            app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            
            app.companyID = app.companyArray[indexPath.row][@"regist_no"];
            app.companyName = app.companyArray[indexPath.row][@"company_name"];
            
            [self.navigationController pushViewController:contentVC animated:YES];
        }
        
    }
    
}

@end
