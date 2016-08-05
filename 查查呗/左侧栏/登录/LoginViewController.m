//
//  LoginViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UIAlertViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
{
    AppDelegate * app;
    NSString * _imei;
    NSString * _keycode;
    NSString * _phoneNum;
    NSString * _userName;
    NSString * _uid;
    NSString * _pwd;
    NSString * _request;
    NSString * _key;
    NSString * _nonce;
    NSString * _timeString;
    SideBarMenuViewController *_sideBarMenuVC;
    BMKMapManager *_mapManager;
    NSString * _flag;
    NSInteger s;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *registereButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];

    [self loadUI];
    
    mbHud.delegate = self;
}

- (void)loadUI
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    app = [AppDelegate sharedAppDelegate];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    NSArray *arrays=[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil];
    UIView *view=arrays[0];
    view.frame=CGRectMake(0,44, [UIUtils getWindowWidth], [UIUtils getWindowHeight]);
    self.view=view;
    
    //头像
    NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
    if (!data) {
        _headImageView.image=[UIImage imageNamed:@"touxiang.png"];
    }else{
        _headImageView.image=[UIImage imageWithData:data];
    }
    
    //保持圆形头像
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius=45;
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(image)
                                                 name:@"image" object:nil];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //用户登录过一次之后，第二次登陆默认显示之前的手机号和密码
    SaveInfo;
    
    //设置textfiel的代理
    _passTextField.secureTextEntry = YES;
    _numberTextField.delegate = self;
    _passTextField.delegate = self;

    _numberTextField.keyboardType = UIKeyboardTypePhonePad;
    _passTextField.keyboardType = UIKeyboardTypeAlphabet;

    //uuid
    UUID;
    
    //六位随机数
    NONCE;
    
}

- (void)image
{
    NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
    
    _headImageView.image=[UIImage imageWithData:data];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"会员登陆";
//    为导航栏添加左侧按钮
    Backbutton;
    
}

- (void)backButton
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"你确定要退出程序吗？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.delegate = self;
    [alert show];
  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    app = [AppDelegate sharedAppDelegate];
    app.isLogin = NO;
    
    if (buttonIndex == 1) {
        
        exit(0);
        
    }
    
    if (alertView.tag == 10) {
        
        if (buttonIndex == 0) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/cha-cha-bei/id1111485201?mt=8"]];
        }
    }
}

#pragma mark - 用户进入app时请求参数
- (void)loadData
{
    app = [AppDelegate sharedAppDelegate];
    
    //发送请求
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] GET:CANSHU_URL parameters:nil result:^(id responseObject, NSError *error) {
                
                //参数返回失败
                if ([responseObject[@"status"] intValue] != 1 || responseObject == nil) {
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示!" message:@"请求失败,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else{//参数返回成功
                    
                    //保存参数返回信息
                    SaveParam;
                    app = [AppDelegate sharedAppDelegate];
                    app.keycode = responseObject[@"result"][@"keycode"];
                    app.request = responseObject[@"response"];

                    //解密
                    _pwd = [AESCrypt decrypt:app.keycode];

                    [self checkVersion];
                    
                }

            }];
            
        }else{
            
           noWebhud;

        }
    }];
    
}

- (void)checkVersion
{
    //获取用户最新的版本号:info.plist
    NSString * curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString * systype = @"2";
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:curVersion,@"version",systype,@"systype", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:Check_version_URL parameters:pdic result:^(id responseObject, NSError *error) {

                NSLog(@"版本更新提示:%@",responseObject);
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    _flag = responseObject[@"result"][@"flag"];

                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"检测更新：查查呗" message:@"发现新版本（1.0.6）" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"升级", nil];
                    
                    alert.delegate = self;
                    
                    [alert show];
                    
                    alert.tag = 10;

                }
                
            }];
            
        }else{
            
            noWebhud;
        }
    }];
    
}

- (void)loadFreeLogin
{
    app = [AppDelegate sharedAppDelegate];
    
    _keycode = app.keycode;
    
    _imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:_keycode]];
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keycode,@"keycode",_imei,@"imei", nil];
    
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

            [[HTTPSessionManager sharedManager] POST:Submitimei_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                NSLog(@"%@",responseObject);
                
                if ([responseObject[@"status"] integerValue] != 1) {
                    
                    [mbHud setMode:MBProgressHUDModeText];
                    mbHud.labelText = @"请求出错，请重试";
                    [mbHud hide:YES afterDelay:2.0];
                    
                }else{
                    
                    app.noLoginKeycode = responseObject[@"result"][@"keycode"];
                    app.request = responseObject[@"response"];
                    app.isLogin = NO;
                    
                    [self loadCompanyData];
                }
                
            }];
            
        }else{
            
            noWebhud;
        }
        
    }];
    
    
}

#pragma  mark - 注册按钮点击事件
- (IBAction)registeredButtonClick:(id)sender {
    
    RegisteredViewController *registeredVC=[[RegisteredViewController alloc]initWithNibName:@"RegisteredViewController" bundle:nil];
    UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:registeredVC];
    [self presentViewController:naviController animated:YES completion:nil];
    
}

#pragma mark - 我想试用
- (IBAction)freeUse:(id)sender {

    [self loadFreeLogin];
    app = [AppDelegate sharedAppDelegate];
    app.isLogin = NO;

}

#pragma mark - 登陆按钮点击事件
- (IBAction)loginButtonClick:(id)sender {
    
    [self.view endEditing:YES];
    
    app = [AppDelegate sharedAppDelegate];
    
    //参数不对的情况
    if (JudgeNumAndPass) {//手机号和密码皆为空
        
        AlertViewWhenNull;
        
    }else if (_numberTextField.text.length==0){//手机号为空
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入手机号！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (_passTextField.text.length == 0){//密码为空
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        [self loginSuccess];

    }
    
}

#pragma mark - “忘记密码”按钮点击事件
- (IBAction)forgotButtonClick:(id)sender {
    
    ForgetPasswordViewController * forget = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
}

#pragma  mark - 登陆成功时调用的方法
-(void)loginSuccess
{
    app  =[AppDelegate sharedAppDelegate];
    app.isLogin = YES;
    
    //加密
    NSString * encryptionStr1 = [AESCrypt encrypt:_numberTextField.text password:_pwd];
    NSString * encryptionStr2 = [AESCrypt encrypt:_passTextField.text password:_pwd];
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode", encryptionStr1,@"telno",encryptionStr2,@"password", nil];
    
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:DENGLU_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"status"] intValue] == 1) {
                    
                    app.uid = responseObject[@"result"][@"uid"];
                    app.request = responseObject[@"response"];
                    app.isLogin = YES;
                    app.loginKeycode = responseObject[@"result"][@"keycode"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:_numberTextField.text forKey:@"phonenum"];
                    [[NSUserDefaults standardUserDefaults] setObject:_passTextField.text forKey:@"passnum"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    app.phonenum = _numberTextField.text;
                    app.password = _passTextField.text;
                    
                    _userName = [AESCrypt decrypt: responseObject[@"result"][@"nickname"] password:[AESCrypt decrypt:app.loginKeycode]];
                    _phoneNum = [AESCrypt decrypt: responseObject[@"result"][@"mobilephone"] password:[AESCrypt decrypt:app.loginKeycode]];
                    
                    app.email = [AESCrypt decrypt: responseObject[@"result"][@"email"] password:[AESCrypt decrypt:app.loginKeycode]];
                    
                    mbHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                    mbHud.labelText = @"登录中...";

                    //加载热门企业数据
                    [self loadCompanyData];
                    
                }else{
                    
                    [mbHud setMode:MBProgressHUDModeText];
                    mbHud.labelText = @"请求出错，请重试";
                    [mbHud hide:YES afterDelay:2.0];

                }

            }];
            
        }else{
            
            noWebhud;
        }
        
    }];

}
#pragma mark - 提前加载热门企业
- (void)loadCompanyData
{
    app = [AppDelegate sharedAppDelegate];
    _uid = app.uid;
    _request = app.request;
    
    if (app.isLogin == YES) {//已登陆用户
        
        //封装POST参数
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_request,@"request", nil];
        
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:Company_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    NSLog(@"\n请求:%@",responseObject);
                    
                    app.companyArray = responseObject[@"result"];
                    app.hotCompanyArray = responseObject[@"result"];
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        [self UntilSeccessDone];
                        
                    }else{
                    
                        [mbHud setMode:MBProgressHUDModeText];
                        mbHud.labelText = @"请求出错，请重试";
                        [mbHud hide:YES afterDelay:2.0];
                    }
                    
                    //保存request
                    app.request = responseObject[@"response"];
                    
                }];

            }else{
                
                noWebhud;

            }
            
        }];
        
    }else{//未登录用户
        
        //imei
        //手机唯一识别码
        _imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.keycode]];
        
        //keycode
        _key = app.noLoginKeycode;
        
        //六位随机数
        NSString * nonceStr = [NSString stringWithFormat:@"%i",(arc4random() % 999999) + 100000];
        _nonce = [AESCrypt encrypt:nonceStr password:[AESCrypt decrypt:app.keycode]];
        //时间戳
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMddmmss"];
        
        _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:app.keycode]];
        
        NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:_imei,@"imei",_request,@"request",_key,@"keycode",_timeString,@"timestamp",_nonce,@"nonce", nil];
        
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:Company_URL parameters:pdic result:^(id responseObject, NSError *error) {
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        app.companyArray = responseObject[@"result"][@"data"];
                        app.hotCompanyArray = responseObject[@"result"][@"data"];
                        
                        [self UntilSeccessDone];
                        
                    }else{
                        
                        [mbHud setMode:MBProgressHUDModeText];
                        mbHud.labelText = @"请求出错，请重试";
                        
                        [mbHud hide:YES afterDelay:2.0];
                    }
                    
                    app.request = responseObject[@"response"];
                    
                }];

            }else{
                
                noWebhud;

            }
            
        }];
        
    }
    
}

#define mark - textfield可输入字数限制
#pragma mark - textField代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1) {
        
        NSString * phoneString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (phoneString.length > 11 && range.length != 1) {
            _numberTextField.text = [phoneString substringToIndex:11];
            return NO;
        }

    }else if(textField.tag == 2){
    
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
        if (passString.length > 16 && range.length != 1) {
            _passTextField.text = [passString substringToIndex:16];
            return NO;
        }
        
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

#pragma mark - 进入“首页”界面
- (void)UntilSeccessDone
{
    [mbHud hide:YES];
    
    //初始化_sideBarMenuVC
    UIViewController *viewController = [[UIViewController alloc] init];
    _sideBarMenuVC = [[SideBarMenuViewController alloc] initWithRootViewController:viewController];
    
    //设定_sideBarMenuVC的左侧栏
    LeftViewController *leftViewController= [[LeftViewController alloc] init];
    leftViewController.sideBarMenuVC = _sideBarMenuVC;
    _sideBarMenuVC.leftViewController = leftViewController;
    //leftViewController展示主视图
    [leftViewController showViewControllerWithIndex:0];
    self.view.window.rootViewController = _sideBarMenuVC;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
