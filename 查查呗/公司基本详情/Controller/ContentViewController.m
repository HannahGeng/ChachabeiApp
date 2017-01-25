//
//  ContentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate,SendViewDelegate>
{
    UIView *_taberView;
    UIButton *_commentButton;
    UIButton *_shareButtn;
    UIButton *_focusButton;
    UIButton * _noFocusButton;
    UIButton *_sendBtn;
    NSInteger _rowIndex;
    NSString * _companyId;
    NSString * _timeString;
    NSString * _imei;
    NSString * _focus_state;
    NSString * _url;
    NSString * _province;
    NSString * _emailStr;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (strong, nonatomic) IBOutlet UITableView *ContentTableView;
@property (nonatomic,strong) NSArray * companys;
@property (nonatomic,strong) NSArray * resultCompanys;

@end

@implementation ContentViewController

-(void)viewWillAppear:(BOOL)animated
{
    AppShare;
    
    [self.ContentTableView reloadData];
    
    ResultsViewController * result = [[ResultsViewController alloc] init];
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[result class]]) {
    
        app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.resultArray[[app.companyIndex integerValue]]];
    }
    
    app.tabView.hidden = NO;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppShare;
    
    mbHUDinit;
    
    [self loadCompanyArray];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
    //接收底部工具栏按钮通知
    [self resiveNoti];
    
    //判断关注按钮点击状态
    [self addContent];
    
    //添加底部控件
    CGFloat height = 45;
    app.tabView = [[CCBTabBarView alloc] initWithFrame:CGRectMake(0, screen_height - height, screen_width, height)];
    [KWindow addSubview:app.tabView];
}

- (void)resiveNoti
{
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentClick) name:@"comment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareClick) name:@"share" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(focusClick:) name:@"attent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendClick) name:@"send" object:nil];

}

- (void)addContent
{
    AppShare;
    
    //如果关注数组不为空
    if ((![app.attentionArray isEqual:@"暂无关注企业"]) && (app.attentionArray.count != 0) && (app.isLogin == YES) && (![app.attentionArray isEqual:[NSNull null]])) {
        
        for (int i = 0; i < app.attentionArray.count; i++) {
            
            //如果所点击的公司id与关注公司的id相同，则证明该企业已被关注
            if ([app.attentionArray[i][@"cid"] containsString:app.companyID]) {
                
                break;
            }
            
        }
    }

}

- (void)loadCompanyArray
{
    AppShare;
    
    ResultsViewController * result = [[ResultsViewController alloc] init];
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[result class]]) {//result界面push进来的
        
        //省份
        _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:app.loginKeycode]];
        
        //时间戳
        loginTimeStr;
        
        _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
        
        NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",_companyId,@"registNo",[AESCrypt encrypt:app.url password:[AESCrypt decrypt:app.loginKeycode]],@"url",[AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]],@"nonce",_timeString,@"timestamp",_province,@"province", nil];
        
        NSDictionary * Dic = [NSDictionary dictionaryWithObjectsAndKeys:_companyId,@"eid",app.request,@"request",app.uid,@"uid",[AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]],@"nonce",_timeString,@"timestamp", nil];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                //无验证码的企业详情
                if (app.url == nil) {

                    [[HTTPSessionManager sharedManager] POST:Hot_Detail_URL parameters:Dic result:^(id responseObject, NSError *error) {
                        
                        NSLog(@"企业详情:%@",responseObject);
                        
                        app.companyDetailContent = responseObject[@"result"][@"data"];
                        app.request = responseObject[@"response"];
                        app.basicInfo = responseObject[@"result"][@"data"][@"basicInfo"];
                        app.dataArr = app.basicInfo;
                        
                        app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                        
                        [self.ContentTableView reloadData];
                        
                        hudHide;

                    }];
                    
                }else{
                    
                    //有验证码的企业详情
                    [[HTTPSessionManager sharedManager] POST:Company_Detail_URL parameters:pdic result:^(id responseObject, NSError *error) {
                    
                        if ([responseObject[@"status"] integerValue] == 1) {
                            
                            app.request = responseObject[@"response"];

                            app.dataArr = responseObject[@"result"][@"data"];
                            
                            if (app.dataArr.count == 0) {
                                
                                hudHide;

                                MBhud(@"暂无信息");
                                
                            }else
                            {
                                app.companyDetailContent = responseObject[@"result"];
                                app.basicInfo = responseObject[@"result"][@"data"][@"basicInfo"];
                                app.dataArr = app.basicInfo;
                                app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                                
                                [self.ContentTableView reloadData];
                                hudHide;
                            }
                            
                        }else{
                            
                            hudHide;
                            MBhud(@"暂无结果")
                        }
                    }];
                }
                
            }else{
                
                hudHide;
                noWebhud;
            }
        }];
    
    }else{//首页push进来的
        
        if (app.isLogin == YES) {//登陆
            
            //时间戳
            loginTimeStr;
            
            //六位随机数
            NSString * nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]];
            
            //cid
            _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_companyId,@"eid",app.request,@"request",app.uid,@"uid",nonce,@"nonce",_timeString,@"timestamp", nil];
            
            //监控网络状态
            mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
            {
                if (status != 0) {
                    
                    [[HTTPSessionManager sharedManager] POST:Hot_Detail_URL parameters:pDic result:^(id responseObject, NSError *error) {
                        
                        NSLog(@"公司信息:%@",responseObject);
                        
                        if ([responseObject[@"status"] integerValue] == 1) {
                            
                            app.request = responseObject[@"response"];
                            
                            //保存企业详细信息数组源
                            app.basicInfo = responseObject[@"result"][@"data"][@"basicInfo"];
                            
                            app.dataArr = app.basicInfo;
                            
                            app.companyDetailContent = responseObject[@"result"][@"data"];
                            
                            app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                            
                            [self.ContentTableView reloadData];
                            
                            hudHide;

                        }else {
                            
                            hudHide;

                            MBhud(@"暂无结果")
                            
                        }
                    }];
                    
                }else{
                    
                    hudHide;
                    noWebhud;
                }
            }];
            
        }else{//未登陆
            
            //时间戳
            NSDate *  senddate=[NSDate date];
            
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"YYYYMMddmmss"];
            
            _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.noLoginKeycode]];
            
            //六位随机数
            NSString * nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.noLoginKeycode]];
            
            _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.noLoginKeycode]];
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",app.noLoginKeycode,@"keycode",_companyId,@"eid",app.request,@"request",nonce,@"nonce",_timeString,@"timestamp", nil];
            
            //监控网络状态
            mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {

                    [[HTTPSessionManager sharedManager] POST:Hot_Detail_URL parameters:pDic result:^(id responseObject, NSError *error) {
                        
                        if ([responseObject[@"status"] integerValue] == 1){
                            app.request = responseObject[@"response"];
                            
                            //保存企业详细信息数组源
                            app.companyDetailContent = responseObject[@"result"][@"data"][@"data"];
                            
                            app.basicInfo = responseObject[@"result"][@"data"][@"data"][@"basicInfo"];
                            
                            app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                            
                            app.dataArr = app.basicInfo;
                            
                            hudHide;

                            [self.ContentTableView reloadData];
                            
                            hudHide;

                        }else {
                            
                            hudHide;

                            MBhud(@"暂无结果");
                            
                        }
                    }];
                    
                }else{
                    
                    hudHide;
                    noWebhud;
                }
            }];
        }
    }
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    SetNavigationBar(nil);
    
    //为导航栏添加左侧按钮
    Backbutton;
    
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-35, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)remindButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"homeView" object:nil];
}

-(void)backButton
{
    AppShare;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    app.tabView.hidden = YES;
}

-(void)commentClick
{
    CommentViewController *commentVC=[[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:commentVC];
    [self presentViewController:naviController animated:YES completion:nil];
}

-(void)shareClick
{
    NSURL *shareUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/cn/app/cha-cha-bei/id1111485201?mt=8"]];
    
    NSArray *activityItem=@[shareUrl];
    
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:activityItem applicationActivities:nil];
    
    //设置不出现的活动项目
    activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter
                                                 ,UIActivityTypeMessage
                                                 ,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,
                                                 UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,
                                                 UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks
                                                 ];
    
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
    
//    app.tabView.hidden = NO;
//中鼎职信
}

#pragma mark - 点击关注
- (void)focusClick:(id)sender
{
    AppShare;
    
    //cid
    _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
    
    if (app.isLogin == YES) {//已登陆用户
        
        if (app.isFocus) {
            //关注状态
            _focus_state = @"1";
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.companyName password:[AESCrypt decrypt:app.loginKeycode]],@"cname", app.uid,@"uid",app.request,@"request",_companyId,@"cid",_focus_state,@"focus_state", nil];

            //监控网络状态
            mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {
                    
                    [[HTTPSessionManager sharedManager] POST:Change_attention_URL parameters:pDic result:^(id responseObject, NSError *error) {
                                                
                        app.request = responseObject[@"response"];
                        
                    }];
                    
                }else{
                    
                   noWebhud;
                }
            }];
            
        }else{
            
            //关注状态
            _focus_state = @"2";
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.companyName password:[AESCrypt decrypt:app.loginKeycode]],@"cname", app.uid,@"uid",app.request,@"request",_companyId,@"cid",_focus_state,@"focus_state", nil];
            
            //监控网络状态
            mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {
                    
                    [[HTTPSessionManager sharedManager] POST:Change_attention_URL parameters:pDic result:^(id responseObject, NSError *error) {
                        
                        app.request = responseObject[@"response"];
                    }];
                    
                }else{
                    
                    noWebhud;

                }
            }];
        }
        
    }else{//未登录用户
        
        app.tabView.hidden = YES;
        NoLoginWarn;
    }
}

-(void)sendClick
{
    AppShare;
    
    if (app.isLogin == YES) {
        
        [SendCover show];
        
        //弹出发送邮件窗口
        SendView * send = [SendView showInPoint:CGPointMake(self.view.width / 2, 120)];
        
        send.delegate = self;

    }else{
        
        NoLoginWarn;
    }
    
}

- (void)sendMailDidClickSendBtn:(SendView *)send
{
    [self sendEmail];
}

- (void)closeViewDidClickCloseBtn:(SendView *)send
{
    void(^completion)() = ^{
      
        [SendCover hide];
    };
    
    [SendView hideInPoint:CGPointMake(44, 44) completion:completion];
}

- (void)sendEmail
{
    [self.view endEditing:YES];
    
    AppShare;
    
    _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",_companyId,@"eid",[AESCrypt encrypt:app.sendEmail password:[AESCrypt decrypt:app.loginKeycode]],@"email", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:sendEmail_URl parameters:pdic result:^(id responseObject, NSError *error) {
                
                NSLog(@"发送企业报告:%@",responseObject);
                
                app.request = responseObject[@"response"];
                
                MBhud(responseObject[@"result"])
                
                if ([responseObject[@"status"] integerValue] == 1) {
                 
                    void(^completion)() = ^{
                        
                        [SendCover hide];
                    };
                    
                    [SendView hideInPoint:CGPointMake(44, 44) completion:completion];
                }

            }];
            
        }else{
            
            noWebhud;            
        }
    }];
    
}

//键盘退下事件的处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppShare;
    
    if (indexPath.row==0) {
        
        HeardViewCell *cell=[HeardViewCell cellWithTableView:self.ContentTableView];
        cell.backgroundColor = LIGHT_BACKGROUND_COLOR;
        cell.companyDetail =  app.companyModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.row==1) {
        
        TableVC *cell=[TableVC cellWithTableView:self.ContentTableView];
        cell.companyDetail =  app.companyModel;
        cell.backgroundColor = LIGHT_BLUE_COLOR;
        
        return cell;
    }
    
    if (indexPath.row==2) {
        
        AddressVC *cell=[AddressVC cellWithTableView:self.ContentTableView];
        cell.companyDetail =  app.companyModel;
        
        return cell;
    }
    
    if (indexPath.row==3) {
        
        WebVC *cell=[WebVC cellWithTableView:self.ContentTableView];
        cell.companyDetail =  app.companyModel;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    if (indexPath.row==4) {
        
        TopButtonVC *cell=[TopButtonVC cellWithTableView:self.ContentTableView];

        [cell.messageButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    
    }
    
    if (indexPath.row==5) {
        
        InVC *cell=[InVC cellWithTableView:self.ContentTableView];
        
        return cell;
    }
    
    if (indexPath.row==6) {
        
        UnderButtonVC *cell=[UnderButtonVC cellWithTableView:self.ContentTableView];
        
        [cell.reportButton addTarget:self action:@selector(yearClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.mapButton addTarget:self action:@selector(mapClick) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    
    return nil;
}

#pragma mark - 工商信息点击事件
-(void)tapClick
{
    AppShare;

    if (app.dataArr.count == 0) {
        
        MBhud(@"暂无信息");
        
    }else{
        
        SegmentViewController * segment = [[SegmentViewController alloc] init];
        [self.navigationController pushViewController:segment animated:YES];

    }
}

#pragma mark - 年报点击事件
- (void)yearClick
{
    AppShare;
    
    NSArray * yearArr = app.companyDetailContent[@"annualYear"];
    
    app.yearArr = yearArr;
    
    if (yearArr.count == 0) {

        MBhud(@"该企业暂无年报信息");
        
    }else{
        
        if (app.isLogin == YES) {
            
            YearViewController * yearvc = [[YearViewController alloc] init];
            
            [self.navigationController pushViewController:yearvc animated:YES];
            
        }else{

            MBhud(@"登陆后方可查看");
        }
    }
}

- (void)mapClick
{
    ChartViewController * chart = [[ChartViewController alloc] init];
    
    [self.navigationController pushViewController:chart animated:YES];
    
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }
    if (indexPath.row==1||indexPath.row==2){
        return 65;
    }
    if (indexPath.row==3) {
        return 65;
    }
    if (indexPath.row==4) {
        return 80;
    }
    if (indexPath.row==5) {
        return 80;
    }
    if (indexPath.row==6) {
        return 80;
    }
        return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
        
    if (indexPath.row == 3) {
        
        if ([app.urlStr isEqualToString:@"-"]) {
            
            return;
        }else
        {
            CodeController * code = [[CodeController alloc] init];
            
            [self.navigationController pushViewController:code animated:YES];
        }
    }
}

@end
