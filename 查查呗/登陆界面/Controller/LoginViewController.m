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
    NSString * _imei;
    NSString * _keycode;
    NSString * _pwd;
    NSString * _nonce;
    NSString * _timeString;
    BMKMapManager *_mapManager;
    NSString * _flag;
    NSInteger s;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *registereButton;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletePass) name:@"deletePass" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mbHUDinit;
    
    [self loadUI];
    
    mbHud.delegate = self;
}

- (void)deletePass
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passnum"];
    
    _passTextField.text = [SaveTool objectForKey:@"passnum"];
    
    [_passTextField resignFirstResponder];
}

- (void)loadUI
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    AppShare;
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //头像
    NSData *data = [SaveTool objectForKey:@"image"];
    if (!data) {
        _headImageView.image=[UIImage imageNamed:@"touxiang.png"];
    }else{
        _headImageView.image=[UIImage imageWithData:data];
    }
    
    //用户登录过一次之后，第二次登陆默认显示之前的手机号和密码
    SaveInfo;
    
    //uuid
    UUID;
    
    //六位随机数
    NONCE;
}

//点按屏幕退下键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//设置导航栏
-(void)setNavigationBar
{
    SetNavigationBar(@"会员登录");
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
    AppShare;
    app.isLogin = NO;
    
    if (alertView.tag == 10) {
        
        if (buttonIndex == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/cha-cha-bei/id1111485201?mt=8"]];
        }
        
    }else
    {
        if (buttonIndex == 1) {
            
            exit(0);
        }

    }
}

#pragma mark - 用户进入app时请求参数
- (void)loadData
{
    //监控网络状态
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] GET:CANSHU_URL parameters:nil result:^(id responseObject, NSError *error) {
                
                //参数返回失败
                if ([responseObject[@"status"] intValue] == 1) {
                    
                    hudHide;
                    
                    AppShare;
                    app.keycode = responseObject[@"result"][@"keycode"];
                    app.request = responseObject[@"response"];
                    
                    //解密
                    _pwd = [AESCrypt decrypt:app.keycode];
                    
//                    [self checkVersion];

                }else{//参数返回成功
                    
                    MBhud(@"参数返回失败，请重试");
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
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:Check_version_URL parameters:pdic result:^(id responseObject, NSError *error) {
                
                NSLog(@"版本提示:%@",responseObject);
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    _flag = responseObject[@"result"][@"flag"];

                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"检测更新：查查呗" message:@"发现新版本（1.1.0）" delegate:nil cancelButtonTitle:@"忽略" otherButtonTitles:@"升级", nil];

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
    AppShare;
    
    _keycode = app.keycode;
    
    _imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:_keycode]];
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keycode,@"keycode",_imei,@"imei", nil];
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;
            [[HTTPSessionManager sharedManager] POST:Submitimei_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                NSLog(@"%@",responseObject);
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    app.noLoginKeycode = responseObject[@"result"][@"keycode"];
                    app.request = responseObject[@"response"];
                    app.isLogin = NO;
                    
                    [self loadCompanyData];

                }else{
                    
                    MBhud(@"请求出错，请重试");

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
    AppShare;
    app.isLogin = NO;
}

#pragma mark - 登陆按钮点击事件
- (IBAction)loginButtonClick:(id)sender {
    
    [self.view endEditing:YES];
    
    //参数不对的情况
    if (JudgeNumAndPass) {//手机号和密码皆为空
        
        MBhud(@"输入你的账号和密码就可以登录咯");
        
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
    AppShare;
    app.isLogin = YES;
    
    //加密
    NSString * encryptionStr1 = [AESCrypt encrypt:_numberTextField.text password:_pwd];
    NSString * encryptionStr2 = [AESCrypt encrypt:_passTextField.text password:_pwd];
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode", encryptionStr1,@"telno",encryptionStr2,@"password", nil];
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;
            
            [[HTTPSessionManager sharedManager] POST:DENGLU_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"status"] intValue] == 1) {
                    
                    app.uid = responseObject[@"result"][@"uid"];
                    app.request = responseObject[@"response"];
                    app.loginKeycode = responseObject[@"result"][@"keycode"];
                    
                    [SaveTool setObject:_numberTextField.text forKey:@"phonenum"];
                    [SaveTool setObject:_passTextField.text forKey:@"passnum"];
                    
                    app.phonenum = _numberTextField.text;
                    app.password = _passTextField.text;
                    
                    app.email = [AESCrypt decrypt: responseObject[@"result"][@"email"] password:[AESCrypt decrypt:app.loginKeycode]];
                    
                    //加载热门企业数据
                    [self loadCompanyData];
                    
                }else{
                    
                    hudHide;
                    MBhud(responseObject[@"result"]);

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
    AppShare;
    
    if (app.isLogin == YES) {//已登陆用户
        
        //封装POST参数
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request", nil];
        
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:Company_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    //保存request
                    app.request = responseObject[@"response"];

                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        app.isLogin = YES;
                        
                        [self UntilSeccessDone];
                        
                        app.companyArray = responseObject[@"result"][@"data"];
                        app.hotCompanyArray = responseObject[@"result"][@"data"];
                        
                    }else{
                    
                        hudHide;
                        MBhud(@"请求出错，请重试");
                    }
                    
                }];

            }else{
                
                noWebhud;

            }
            
        }];
        
    }else{//未登录用户
        
        //imei
        //手机唯一识别码
        _imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.keycode]];
        
        //六位随机数
        NSString * nonceStr = [NSString stringWithFormat:@"%i",(arc4random() % 999999) + 100000];
        _nonce = [AESCrypt encrypt:nonceStr password:[AESCrypt decrypt:app.keycode]];
        
        //时间戳
        loginTimeStr;
        
        NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:_imei,@"imei",app.request,@"request",app.noLoginKeycode,@"keycode",_timeString,@"timestamp",_nonce,@"nonce", nil];
        
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:Company_URL parameters:pdic result:^(id responseObject, NSError *error) {
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        app.companyArray = responseObject[@"result"][@"data"][@"data"];
                        app.hotCompanyArray = responseObject[@"result"][@"data"][@"data"];
                                            
                        [self UntilSeccessDone];
                        
                    }else{
                        
                        hudHide;
                        MBhud(@"请求出错，请重试");
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

    hudHide;
        
    SHOUYE;
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
