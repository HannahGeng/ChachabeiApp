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
    AppDelegate * app;
    NSString * _imei;
    NSString * _nonce;
    AFNetworkReachabilityManager * mgr;
    UIImageView *_imageView;
    UILabel *_label;
    MBProgressHUD * mbHud;

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
    
    if (_cell.CompanyButton.selected == NO) {
        
        //加载我的关注
//        [self loadAttentionCompany];
        
    }
    
}

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    
    SetNavigationBar;
    self.title = @"首页";
}

#pragma mark - 添加内容视图
-(void)addContentView
{

    if (_cell.CompanyButton.selected == YES) {
        
        self.viewTableView.bounces = YES;
        
    }else{
        
        self.viewTableView.bounces = NO;
    }
}

#pragma mark - 加载”热门企业“数据
- (void)loadHotCompany
{
    app = [AppDelegate sharedAppDelegate];

    NSMutableArray * mArr = [NSMutableArray array];
    
    for (NSDictionary * dic in app.hotCompanyArray) {
        
        CompanyDetail * detail = [[CompanyDetail alloc] initWithDictionary:dic];
        
        [mArr addObject:detail];
    }
    
    self.companyArray = mArr;
    
    [self.companyTableView reloadData];
    
    [self loadAttentionCompany];

}

#pragma mark - 加载“我的关注“数据
- (void)loadAttentionCompany
{
    app = [AppDelegate sharedAppDelegate];

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
                    
                    self.companyArray = [attentionModel mj_objectArrayWithKeyValuesArray:app.attentionArray];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:app.attentionArray forKey:@"attentionArray"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

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
    
    app = [AppDelegate sharedAppDelegate];
    
    if (tableView == self.viewTableView) {
        
        if (indexPath.row==0) {
            SearchViewCell *cell=[SearchViewCell cellWithTableView:self.viewTableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.searchButton addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        if (indexPath.row==1) {
            TopButtonViewCell *cell=[TopButtonViewCell cellWithTableView:self.viewTableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.codeButton setImage:[UIImage imageNamed:@"app21.png"] forState:UIControlStateNormal];
            cell.codeButton.imageEdgeInsets = UIEdgeInsetsMake(-5,28,25,cell.codeButton.titleLabel.bounds.size.width-20);
            [cell.codeButton setTitle:@"扫二维码" forState:UIControlStateNormal];//设置button的title
            cell.codeButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.codeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.codeButton.titleEdgeInsets = UIEdgeInsetsMake(65, -cell.codeButton.titleLabel.bounds.size.width-65, 0, 0);
            [cell.codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.codeButton];
            
            [cell.cardButton setImage:[UIImage imageNamed:@"app22.png"] forState:UIControlStateNormal];
            cell.cardButton.imageEdgeInsets = UIEdgeInsetsMake(-5,25,25,cell.cardButton.titleLabel.bounds.size.width-15);
            [cell.cardButton setTitle:@"扫名片" forState:UIControlStateNormal];//设置button的title
            cell.cardButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.cardButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.cardButton.titleEdgeInsets = UIEdgeInsetsMake(65, -cell.cardButton.titleLabel.bounds.size.width-60, 0, 0);
            [cell.cardButton addTarget:self action:@selector(cardButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.cardButton];
            
            [cell.recordButton setImage:[UIImage imageNamed:@"app23.png"] forState:UIControlStateNormal];
            cell.recordButton.imageEdgeInsets = UIEdgeInsetsMake(-5,32,25,cell.recordButton.titleLabel.bounds.size.width-25);
            [cell.recordButton setTitle:@"失信记录" forState:UIControlStateNormal];//设置button的title
            cell.recordButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.recordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.recordButton.titleEdgeInsets = UIEdgeInsetsMake(65, -cell.recordButton.titleLabel.bounds.size.width-55, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [cell.recordButton addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.recordButton];
            return cell;
        }
        if (indexPath.row==2) {
            ButtonViewCell *cell=[ButtonViewCell cellWithTableView:self.viewTableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.redianButton setImage:[UIImage imageNamed:@"app17.png"] forState:UIControlStateNormal];
            cell.redianButton.imageEdgeInsets = UIEdgeInsetsMake(-5,25,20,cell.redianButton.titleLabel.bounds.size.width);
            [cell.redianButton setTitle:@"热点" forState:UIControlStateNormal];//设置button的title
            cell.redianButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.redianButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.redianButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.redianButton.titleEdgeInsets = UIEdgeInsetsMake(35, -cell.redianButton.titleLabel.bounds.size.width-25, 0, 0);
//                    [_codeButton addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
            [cell.redianButton addTarget:self action:@selector(redianClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.redianButton];
            
            [cell.nearButton setImage:[UIImage imageNamed:@"app18.png"] forState:UIControlStateNormal];
            cell.nearButton.imageEdgeInsets = UIEdgeInsetsMake(-5,25,20,cell.nearButton.titleLabel.bounds.size.width);
            [cell.nearButton setTitle:@"附近" forState:UIControlStateNormal];//设置button的title
            cell.nearButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.nearButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.nearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.nearButton.titleEdgeInsets = UIEdgeInsetsMake(35, -cell.nearButton.titleLabel.bounds.size.width-25, 0, 0);
            [cell.nearButton addTarget:self action:@selector(nearButton) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.nearButton];
            
            [cell.serviceButton setImage:[UIImage imageNamed:@"app19.png"] forState:UIControlStateNormal];
            cell.serviceButton.imageEdgeInsets = UIEdgeInsetsMake(-5,25,20,cell.serviceButton.titleLabel.bounds.size.width);
            [cell.serviceButton setTitle:@"客服" forState:UIControlStateNormal];//设置button的title
            cell.serviceButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
            cell.serviceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.serviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.serviceButton.titleEdgeInsets = UIEdgeInsetsMake(35, -cell.serviceButton.titleLabel.bounds.size.width-25, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            [cell.serviceButton addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.serviceButton];
            
            [cell.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        if (indexPath.row==3) {
            
            _cell=[SegmentViewCell cellWithTableView:self.viewTableView];
            _cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"font_min"];
            if ([str isEqualToString:@"YES"]) {
                _cell.CompanyButton.selected=YES;
            }
            _cell.CompanyButton.selected=YES;
            _cell.CompanyButton.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
            [_cell.CompanyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_cell.CompanyButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateSelected];
            [_cell.CompanyButton addTarget:self action:@selector(companyClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *str1= [[NSUserDefaults standardUserDefaults] objectForKey:@"font_max"];
            if ([str1 isEqualToString:@"YES"]) {
                _cell.CompanyButton.selected=YES;
            }
//            _cell.FocusButton.selected=YES;
            _cell.FocusButton.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
            [_cell.FocusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_cell.FocusButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateSelected];
            
            if (_cell.FocusButton.selected == NO) {
                
                [_cell.FocusButton addTarget:self action:@selector(focusClick) forControlEvents:UIControlEventTouchUpInside];
            }
            _cell.LineIamgeView.backgroundColor=LIGHT_BLUE_COLOR;
            _cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return _cell;
        }

    }else{
        
        if (_cell.CompanyButton.selected == YES) {
        
            ArrayViewCell *cell=[ArrayViewCell cellWithTableView:tableView];
            
            cell.company = self.companyArray[indexPath.row];
                                 
            return cell;
            
        }else{
            
            if ([app.attentionArray isEqual:@"暂无关注企业"]) {
                
                UITableViewCell *cell=[[UITableViewCell alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else{
                
                ArrayViewCell *cell=[ArrayViewCell cellWithTableView:tableView];
                
                cell.company = self.companyArray[indexPath.row];
                
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
    app = [AppDelegate sharedAppDelegate];

    [_imageView removeFromSuperview];
    [_label removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_min"];
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_max"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _cell.FocusButton.selected=NO;
    
    if ([_cell.CompanyButton isSelected]) {
        _cell.CompanyButton.selected=YES;
    }else{
        _cell.CompanyButton.selected=YES;
    }
    
    _cell.LineIamgeView.frame=CGRectMake(0, 48, [UIUtils getWindowWidth]/2, 3);
    self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    app.companyArray = app.hotCompanyArray;
    
    _uid = app.uid;
    _request = app.request;
    
    self.companyArray = [CompanyDetail mj_objectArrayWithKeyValuesArray:app.hotCompanyArray];
    
    [self.companyTableView reloadData];

}

#pragma mark - “我的关注”按钮
-(void)focusClick
{
    app = [AppDelegate sharedAppDelegate];
//    NSLog(@"%zd",_cell.FocusButton.isSelected);
    if (app.isLogin == YES) {//已登陆用户
        
        NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
        NSArray * attentionArray = [defau arrayForKey:@"attentionArray"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([app.attentionArray isEqual:@"暂无关注企业"]) {
            
            if (_cell.FocusButton.isSelected == NO) {
                self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-50)/2, CGRectGetMaxY(self.viewTableView.frame) + 25,50, 50)];
                _imageView.image=[UIImage imageNamed:@"app24.png"];
                [self.view addSubview:_imageView];
                
                _label=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-130)/2, CGRectGetMaxY(_imageView.frame)+10, 130, 30)];
                _label.text=@"暂无关注企业";
                _label.textAlignment=NSTextAlignmentCenter;
                _label.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:_label];
                UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
                view.backgroundColor=LIGHT_GREY_COLOR;
                [self.companyTableView reloadData];
            }
            
        }else{
        
            self.companyArray =  [attentionModel mj_objectArrayWithKeyValuesArray:attentionArray];
            [self.companyTableView reloadData];
        }
        
    }else{//未登录用户
        
        if (_cell.FocusButton.isSelected == NO) {
            
            self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self loadAttentionCompany];
            _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-50)/2, CGRectGetMaxY(self.viewTableView.frame) + 25,50, 50)];
            _imageView.image=[UIImage imageNamed:@"app24.png"];
            [self.view addSubview:_imageView];
            
            _label=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-130)/2, CGRectGetMaxY(_imageView.frame)+10, 130, 30)];
            _label.text=@"登陆后可查看";
            _label.textAlignment=NSTextAlignmentCenter;
            _label.font=[UIFont systemFontOfSize:14];
            [self.view addSubview:_label];
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
            view.backgroundColor=LIGHT_GREY_COLOR;
            
            [self.companyTableView reloadData];

        }
       
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_min"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_max"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
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
    app = [AppDelegate sharedAppDelegate];
    
    //点击后变成原色
    [self.viewTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.companyTableView) {
        
        if (app.isLogin == YES) {//已登陆用户
            
            ContentViewController *contentVC=[[ContentViewController alloc]init];
            
            if (_cell.CompanyButton.selected == YES) {
                
                //公司索引
                app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                
                //公司ID
                app.companyID = app.companyArray[indexPath.row][@"regist_no"];
                
                app.companyName = app.companyArray[indexPath.row][@"company_name"];
                
                [self.navigationController pushViewController:contentVC animated:YES];

            }else{//我的关注
                
                    if ([app.attentionArray isEqual:@"暂无关注企业"]) {
                    
                }else{
                    
                    //公司索引
                    app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
                    
                    //公司ID
                    app.companyID = app.attentionArray[indexPath.row][@"cid"];
                    
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
