//
//  ContentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_taberView;
    UIButton *_commentButton;
    UIButton *_shareButtn;
    UIButton *_focusButton;
    UIButton * _noFocusButton;
    UIButton *_sendButton;
    UIView *_shareView;
    UIView *_contentView;
    UILabel *_titleLable;
    UIImageView *_imageView;
    UITextField *_emailTextFidld;
    UIButton *_sendBtn;
    UILabel *_lineLabel;
    NSInteger _rowIndex;
    NSString * _companyId;
    NSString * _timeString;
    NSString * _imei;
    NSString * _focus_state;
    NSString * _url;
    NSString * _province;
    NSString * _emailStr;
    BOOL _isFocus;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITableView *ContentTableView;
@property (nonatomic,strong) NSArray * companys;
@property (nonatomic,strong) NSArray * resultCompanys;

@end

@implementation ContentViewController

-(void)viewWillAppear:(BOOL)animated
{
    _taberView.hidden=NO;
    
    [self.ContentTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mbHUDinit;
    [self loadCompanyArray];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
    
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
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMddmmss"];
        
        _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.loginKeycode]];
        
        _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
        
        NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",_companyId,@"eid",app.url,@"url",[AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]],@"nonce",_timeString,@"timestamp",_province,@"province", nil];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:Company_Detail_URL parameters:pdic result:^(id responseObject, NSError *error) {
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                    
                        app.companyDetailContent = responseObject[@"result"];
                        app.request = responseObject[@"response"];
                        app.basicInfo = responseObject[@"result"][@"basicInfo"];
                        app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                        
                        [self.ContentTableView reloadData];
                        hudHide;

                    }else{
                        
                        hudHide;
                        MBhud(@"暂无结果")
                        
                    }
                }];
                
            }else{
                
                hudHide;
                noWebhud;
                
            }
        }];
    
    }else{//首页push进来的
        
        if (app.isLogin == YES) {//登陆
            //时间戳
            NSDate *  senddate=[NSDate date];
            
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"YYYYMMddmmss"];
            
            _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.loginKeycode]];
            
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
                        
                        if ([responseObject[@"status"] integerValue] == 1) {
                            
                            app.request = responseObject[@"response"];
                            
                            //保存企业详细信息数组源
                            app.basicInfo = responseObject[@"result"][@"data"];
                            
                            app.companyDetailContent = responseObject[@"result"][@"data"][@"basicInfo"];
                            
                            app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.companyDetailContent];
                            
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
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",app.noLoginKeycode,@"keycode",_companyId,@"registNo",app.request,@"request",nonce,@"nonce",_timeString,@"timestamp", nil];
            
            //监控网络状态
            mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {
                    
                    [[HTTPSessionManager sharedManager] POST:Hot_Detail_URL parameters:pDic result:^(id responseObject, NSError *error) {
                        
                        if ([responseObject[@"status"] integerValue] == 1){
                        
                            app.request = responseObject[@"response"];
                            
                            //保存企业详细信息数组源
                            app.companyDetailContent = responseObject[@"result"][@"data"];
                            
                            app.basicInfo = responseObject[@"result"][@"data"][@"basicInfo"];
                            app.companyModel = [[CompanyDetail alloc] initWithDictionary:app.basicInfo];
                            
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
    [self.navigationItem setHidesBackButton:YES];
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
//    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
    
}

-(void)backButton
{
    [_taberView removeFromSuperview];
    
    ViewController * vc = [[ViewController alloc] init];
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[vc class]]) {
        //发送通知
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"homeView" object:nil];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

//添加底部试图
-(void)addContentView
{
    AppShare;
    _taberView=[[UIView alloc]initWithFrame:CGRectMake(0, [UIUtils getWindowHeight]-50, [UIUtils getWindowWidth], 50)];
    _taberView.backgroundColor=LIGHT_BLUE_COLOR;
    [[[UIApplication sharedApplication] keyWindow] addSubview: _taberView];

    //评论按钮
    _commentButton = [self buttonWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth]/4, 50) image:@"app33.png" imageEdgeInset:UIEdgeInsetsMake(10,10,25,_commentButton.titleLabel.bounds.size.width-7) titleEdgeInsets:UIEdgeInsetsMake(23, -_commentButton.titleLabel.bounds.size.width-25, 0, 0) action:@selector(commentClick) title:@"评论"];

    //分享按钮
    _shareButtn = [self buttonWithFrame:CGRectMake([UIUtils getWindowWidth]/4, 0, [UIUtils getWindowWidth]/4, 50) image:@"app34.png" imageEdgeInset:UIEdgeInsetsMake(10,10,25,_commentButton.titleLabel.bounds.size.width-7) titleEdgeInsets:UIEdgeInsetsMake(23, -_commentButton.titleLabel.bounds.size.width-25, 0, 0) action:@selector(shareClick) title:@"分享"];

    //关注按钮
    _focusButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _focusButton.frame=CGRectMake([UIUtils getWindowWidth]/4*2, 0, [UIUtils getWindowWidth]/4, 50);

    [_focusButton setImage:[UIImage imageNamed:@"app35"] forState:UIControlStateNormal];
    [_focusButton setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateSelected];
    
    if ([UIUtils getWindowWidth] == 375) {//iphone6
        
         _focusButton.imageEdgeInsets = UIEdgeInsetsMake(10,[UIUtils getWindowWidth]/4-60,24,[UIUtils getWindowWidth]/4-55);
        
    }else if([UIUtils getWindowWidth] == 414){//plus
        
        _focusButton.imageEdgeInsets = UIEdgeInsetsMake(10,40,24,42);
        
    }else{//5s
        
        _focusButton.imageEdgeInsets = UIEdgeInsetsMake(10,30,24,32);
    }
    
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];//设置button的title
    _focusButton.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
    _focusButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_focusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _focusButton.titleEdgeInsets = UIEdgeInsetsMake(25, -_commentButton.titleLabel.bounds.size.width-35, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    [_focusButton addTarget:self action:@selector(focusClick:) forControlEvents:UIControlEventTouchUpInside];

    [_taberView addSubview:_focusButton];
    
    //如果关注数组不为空
    if ((![app.attentionArray isEqual:@"暂无关注企业"]) && (app.attentionArray.count != 0) && (app.isLogin == YES) && (![app.attentionArray isEqual:[NSNull null]])) {
        
        for (int i = 0; i < app.attentionArray.count; i++) {
            
            //如果所点击的公司id与关注公司的id相同，则证明该企业已被关注
            if ([app.attentionArray[i][@"cid"] containsString:app.companyID]) {
                
                _focusButton.selected = YES;
                _isFocus = YES;
                
                break;

            }
            
        }
        
    }
    
    //发送按钮
    _sendBtn = [self buttonWithFrame:CGRectMake([UIUtils getWindowWidth]/4*3, 0, [UIUtils getWindowWidth]/4, 50) image:@"app36.png" imageEdgeInset:UIEdgeInsetsMake(10,10,25,_commentButton.titleLabel.bounds.size.width-7) titleEdgeInsets:UIEdgeInsetsMake(23, -_commentButton.titleLabel.bounds.size.width-25, 0, 0) action:@selector(sendClick) title:@"发送"];
}

#pragma mark - 封装递补工具条按钮
- (UIButton *)buttonWithFrame:(CGRect)frame image:(NSString *)image imageEdgeInset:(UIEdgeInsets)imageInset titleEdgeInsets:(UIEdgeInsets)titleInset action:(SEL)action title:(NSString *)title
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= frame;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.imageEdgeInsets = imageInset;
    [button setTitle:title forState:UIControlStateNormal];//设置button的title
    button.titleLabel.font = [UIFont systemFontOfSize:14];//title字体大小
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleEdgeInsets = titleInset;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_taberView addSubview:button];
    
    return button;
}

-(void)commentClick
{
    CommentViewController *commentVC=[[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:commentVC];
    [self presentViewController:naviController animated:YES completion:nil];
}

-(void)shareClick
{
    
    _taberView.hidden=YES;
    
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
    
    _taberView.hidden=NO;

}

#pragma mark - 点击关注
- (void)focusClick:(id)sender
{
    AppShare;
    
    //cid
    _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
    
    if (app.isLogin == YES) {//已登陆用户
        
        UIButton * button = (UIButton *)sender;
        button.selected = !button.selected;
        _isFocus = button.selected;
        
        if (_isFocus == YES) {
            //关注状态
            _focus_state = @"1";
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.companyName password:[AESCrypt decrypt:app.loginKeycode]],@"cname", app.uid,@"uid",app.request,@"request",_companyId,@"eid",_focus_state,@"focus_state", nil];

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
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:[AESCrypt encrypt:app.companyName password:[AESCrypt decrypt:app.loginKeycode]],@"cname", app.uid,@"uid",app.request,@"request",_companyId,@"eid",_focus_state,@"focus_state", nil];
            
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
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号登录" message:@"匿名用户，你还没有登录！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:naviController animated:YES completion:nil];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
   
}

-(void)sendClick
{
    AppShare;
    
    if (app.isLogin == YES) {
        
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight])];
        UITapGestureRecognizer *tapContentGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [_shareView addGestureRecognizer:tapContentGesture];
        
        [_shareView setBackgroundColor:LIGHT_OPAQUE_BLACK_COLOR];
        self.tabBarController.tabBar.hidden=YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_shareView];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIUtils getWindowWidth], 120)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_shareView addSubview:_contentView];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 40)];
        _titleLable.backgroundColor=LIGHT_BLUE_COLOR;
        _titleLable.text=@"     发送企业信息报告";
        _titleLable.textColor=[UIColor whiteColor];
        _titleLable.font=[UIFont systemFontOfSize:16];
        [_contentView addSubview:_titleLable];
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 65, 30,30)];
        _imageView.image=[UIImage imageNamed:@"app07.png"];
        [_contentView addSubview:_imageView];
        
        _emailTextFidld=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 65, 250, 30)];
        _emailTextFidld.placeholder=@"输入你的邮箱地址";
        [_contentView addSubview:_emailTextFidld];
        
        _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame=CGRectMake(CGRectGetMaxX(_emailTextFidld.frame), 65, 50, 30);
        _sendBtn.backgroundColor=GREEN_COLOR;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.layer.cornerRadius=5;
        [_sendBtn addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_sendBtn];
        
        _lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageView.frame)+3, 280, 1)];
        _lineLabel.backgroundColor=[UIColor lightGrayColor];
        [_contentView addSubview:_lineLabel];
        
        [_emailTextFidld becomeFirstResponder];

    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号登录" message:@"匿名用户，你还没有登录！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:naviController animated:YES completion:nil];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];

    }
    
}
- (void)removeView
{
    [UIView animateWithDuration:0.3 animations:^{
                         
        [_shareView setFrame:CGRectMake(0, [UIUtils getWindowHeight], [UIUtils getWindowWidth], SHARE_CONTENT_HEIGHT)];
                         
    } completion:^(BOOL finished) {
                         
        [_shareView removeFromSuperview];
                         
    }];
    
}

- (void)sendEmail
{
    [self.view endEditing:YES];
    AppShare;
    
    _companyId = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]];
    _emailStr = [AESCrypt encrypt:_emailTextFidld.text password:[AESCrypt decrypt:app.loginKeycode]];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",_companyId,@"cid",_emailStr,@"email", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:sendEmail_URl parameters:pdic result:^(id responseObject, NSError *error) {
                
                app.request = responseObject[@"response"];
                
                MBhud(responseObject[@"result"])
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    [UIView animateWithDuration:1.0 animations:^{
                        
                        [_shareView removeFromSuperview];
                        
                    }];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = LIGHT_BACKGROUND_COLOR;
        
        cell.companyDetail =  app.companyModel;
        
        return cell;
    }
    if (indexPath.row==1) {
        
        TableVC *cell=[TableVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;
        cell.backgroundColor = LIGHT_BLUE_COLOR;
        return cell;
    }
    if (indexPath.row==2) {
        AddressVC *cell=[AddressVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyDetail =  app.companyModel;
        return cell;
    }
    if (indexPath.row==3) {
        WebVC *cell=[WebVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.row==4) {
        
        TopButtonVC *cell=[TopButtonVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.messageButton setImage:[UIImage imageNamed:@"app41.png"] forState:UIControlStateNormal];
        cell.messageButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.messageButton.titleLabel.bounds.size.width-7);
        [cell.messageButton setTitle:@"工商信息" forState:UIControlStateNormal];//设置button的title
        cell.messageButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.messageButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.messageButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell.messageButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.messageButton];
        
        [cell.introduceButton setImage:[UIImage imageNamed:@"app422.png"] forState:UIControlStateNormal];
        cell.introduceButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.introduceButton.titleLabel.bounds.size.width-7);
        [cell.introduceButton setTitle:@"公司介绍" forState:UIControlStateNormal];//设置button的title
        cell.introduceButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.introduceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.introduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.introduceButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.introduceButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell addSubview:cell.introduceButton];
        
        [cell.creditButton setImage:[UIImage imageNamed:@"app433.png"] forState:UIControlStateNormal];
        cell.creditButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.creditButton.titleLabel.bounds.size.width-7);
        [cell.creditButton setTitle:@"信用评级" forState:UIControlStateNormal];//设置button的title
        cell.creditButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.creditButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.creditButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.creditButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.creditButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell addSubview:cell.creditButton];
        
        [cell.authorizationButton setImage:[UIImage imageNamed:@"app444.png"] forState:UIControlStateNormal];
        cell.authorizationButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.authorizationButton.titleLabel.bounds.size.width-7);
        [cell.authorizationButton setTitle:@"授权记录" forState:UIControlStateNormal];//设置button的title
        cell.authorizationButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.authorizationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.authorizationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.authorizationButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.authorizationButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell addSubview:cell.authorizationButton];
        
        return cell;
    
    }
    if (indexPath.row==5) {
        
        InVC *cell=[InVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.cardButton setImage:[UIImage imageNamed:@"app455.png"] forState:UIControlStateNormal];
        cell.cardButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.cardButton.titleLabel.bounds.size.width-7);
        [cell.cardButton setTitle:@"企业二维码" forState:UIControlStateNormal];//设置button的title
        cell.cardButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.cardButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.cardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.cardButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.cardButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell addSubview:cell.cardButton];
        
        [cell.trademarkButton setImage:[UIImage imageNamed:@"app466.png"] forState:UIControlStateNormal];
        cell.trademarkButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.trademarkButton.titleLabel.bounds.size.width-7);
        [cell.trademarkButton setTitle:@"商标展示" forState:UIControlStateNormal];//设置button的title
        cell.trademarkButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.trademarkButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.trademarkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.trademarkButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.trademarkButton.titleLabel.bounds.size.width-25, 0, 0);
        //        [cell.trademarkButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.trademarkButton];
        
        [cell.promisesButton setImage:[UIImage imageNamed:@"app47.png"] forState:UIControlStateNormal];
        cell.promisesButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.promisesButton.titleLabel.bounds.size.width-7);
        [cell.promisesButton setTitle:@"失信记录" forState:UIControlStateNormal];//设置button的title
        cell.promisesButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.promisesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.promisesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.promisesButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.promisesButton.titleLabel.bounds.size.width-25, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        //        [cell.promisesButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.promisesButton];
        
        [cell.recruitmentButton setImage:[UIImage imageNamed:@"app488.png"] forState:UIControlStateNormal];
        cell.recruitmentButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.recruitmentButton.titleLabel.bounds.size.width-7);
        [cell.recruitmentButton setTitle:@"招聘信息" forState:UIControlStateNormal];//设置button的title
        cell.recruitmentButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.recruitmentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.recruitmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.recruitmentButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.recruitmentButton.titleLabel.bounds.size.width-25, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        //        [cell.recruitmentButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.recruitmentButton];

        return cell;
    }
    if (indexPath.row==6) {
        
        UnderButtonVC *cell=[UnderButtonVC cellWithTableView:self.ContentTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.investorsButton setImage:[UIImage imageNamed:@"app499.png"] forState:UIControlStateNormal];
        cell.investorsButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.investorsButton.titleLabel.bounds.size.width-7);
        [cell.investorsButton setTitle:@"投资人" forState:UIControlStateNormal];//设置button的title
        cell.investorsButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.investorsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.investorsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.investorsButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.investorsButton.titleLabel.bounds.size.width-25, 0, 0);
        //        [cell.investorsButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.investorsButton];
        
        [cell.reportButton setImage:[UIImage imageNamed:@"app50.png"] forState:UIControlStateNormal];
        cell.reportButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.reportButton.titleLabel.bounds.size.width-7);
        [cell.reportButton setTitle:@"企业年报" forState:UIControlStateNormal];//设置button的title
        cell.reportButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.reportButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.reportButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.reportButton.titleLabel.bounds.size.width-25, 0, 0);
        [cell.reportButton addTarget:self action:@selector(yearClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.reportButton];
        
        [cell.mapButton setImage:[UIImage imageNamed:@"app51.png"] forState:UIControlStateNormal];
        cell.mapButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.mapButton.titleLabel.bounds.size.width-7);
        [cell.mapButton setTitle:@"企业图谱" forState:UIControlStateNormal];//设置button的title
        cell.mapButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.mapButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.mapButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.mapButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.mapButton.titleLabel.bounds.size.width-25, 0, 0);
        // [cell.mapButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.mapButton];
        
        [cell.investmentButton setImage:[UIImage imageNamed:@"app52.png"] forState:UIControlStateNormal];
        cell.investmentButton.imageEdgeInsets = UIEdgeInsetsMake(5,28,30,cell.investmentButton.titleLabel.bounds.size.width-7);
        // 设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
        [cell.investmentButton setTitle:@"对外投资" forState:UIControlStateNormal];//设置button的title
        cell.investmentButton.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
        cell.investmentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.investmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.investmentButton.titleEdgeInsets = UIEdgeInsetsMake(45, -cell.investmentButton.titleLabel.bounds.size.width-25, 0, 0);
        // 设置title在button上的位置（上top，左left，下bottom，右right）
        // [cell.investmentButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.investmentButton];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - 工商信息点击事件
-(void)tapClick
{
    SegmentViewController * segment = [[SegmentViewController alloc] init];
    [self.navigationController pushViewController:segment animated:YES];
}

#pragma mark - 年报点击事件
- (void)yearClick
{
    AppShare;
    
    NSArray * yearArr = app.companyDetailContent[@"report_date"];
    
    if (yearArr.count == 0) {
        MBhud(@"该企业暂无年报信息");
    }else{
        
        //六位随机数
        NSString * nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:app.loginKeycode]];
        
        //时间戳
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMddmmss"];
        
        NSString * year = [AESCrypt encrypt:@"2014" password:[AESCrypt decrypt:app.loginKeycode]];
        
        _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.loginKeycode]];
        
        NSLog(@"\nuid:%@\nrequest:%@\nnonce:%@\ntime:%@\nID:%@\nyear:%@",app.uid,app.request,app.nonce,_timeString,app.companyID,year);
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",nonce,@"nonce",_timeString,@"timestamp",[AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:app.loginKeycode]],@"registNo",year,@"year", nil];
        
        
        if (app.isLogin == YES) {
            
            [[HTTPSessionManager sharedManager] POST:YEAR_URL parameters:dic result:^(id responseObject, NSError *error) {
                
                NSLog(@"\n年报信息:%@",responseObject);
                
                app.request = responseObject[@"response"];
            }];
            
            YearViewController * yearvc = [[YearViewController alloc] init];
            
            [self.navigationController pushViewController:yearvc animated:YES];
            
        }else{
            
            MBhud(@"登陆后方可查看");
        }
    }
    
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

@end
