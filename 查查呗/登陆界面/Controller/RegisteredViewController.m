//
//  RegisteredViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/4.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()<UITextFieldDelegate>
{
    NSDictionary * _dic;//参数URL的responseObject
    MBProgressHUD * mbHud;
    NSString * _hudStr;
}
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
/**
 *  手机号码
 */
@property (weak, nonatomic) IBOutlet UITextField *numLabel;
/**
 *  短信验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *messageLabel;
/**
 *  邮箱
 */
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
/**
 *  设置密码
 */
@property (weak, nonatomic) IBOutlet UITextField *passLabel;
/**
 *  确认密码
 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPassLabel;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    //设置导航栏
    [self setNavigationBar];
    
    //设置注册界面样式
    [self setUIStyle];
    
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    SetNavigationBar(@"会员注册");
        
    //为导航栏添加左侧按钮
    Backbutton;
}

- (void)setUIStyle
{
    _verificationButton.layer.masksToBounds=YES;
    _verificationButton.layer.cornerRadius=5;
    
    _timeButton.layer.cornerRadius = 5;
}

- (void)startTime
{
    [_timeButton setBackgroundColor:[UIColor lightGrayColor]];
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _timeButton.backgroundColor = GREEN_COLOR;
                [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _timeButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeout % 100;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_timeButton setTitle:[NSString stringWithFormat:@"已发送%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _timeButton.userInteractionEnabled = NO;
            });
            
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

-(void)backButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)timeClick:(UIButton *)button {
     
    [self.view endEditing:YES];
    
    AppShare;
    
    //手机号加密
    NSString * telePhone = [AESCrypt encrypt:self.numLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode",telePhone,@"telno", nil];
    
    //监控网络状态
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:MsgCode_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                _hudStr = responseObject[@"result"];
                
                MBhud(_hudStr);

                if ([_hudStr isEqualToString:@"验证码发送成功"]) {
                    
                    [self startTime];
                    
                }
                
            }];
            
        }else{
            
            noWebhud;
            
        }
    }];
    
}

#pragma mark - textfield代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1) {
        NSString * phoneString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (phoneString.length > 11 && range.length != 1) {
            _numLabel.text = [phoneString substringToIndex:11];
            return NO;
        }

    }else if (textField.tag == 2){
        
            NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
            if (passString.length > 16 && range.length != 1) {
                _passLabel.text = [passString substringToIndex:16];
                return NO;
            }

    }else if(textField.tag == 3){
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 16 && range.length != 1) {
            _confirmPassLabel.text = [passString substringToIndex:16];
            return NO;
        }

    }else if (textField.tag == 4){
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 16 && range.length != 1) {
            _nameLabel.text = [passString substringToIndex:16];
            return NO;
        }

    }else{
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 6 && range.length != 1) {
            _messageLabel.text = [passString substringToIndex:6];
            return NO;
        }
    }
    
        return YES;
}

#pragma mark - textField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    if (textField.tag == 4) {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.view.frame = CGRectMake(0, -50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];

}

- (IBAction)completeClick:(id)sender {
    
    [self.view endEditing:YES];
    
    AppShare;
    
    //telno
    NSString * telePhone = [AESCrypt encrypt:self.numLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //msgcode
    NSString * messageCode = [AESCrypt encrypt:self.messageLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //emai
    NSString * email = [AESCrypt encrypt:self.emailLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //nickname
    NSString * nickName = [AESCrypt encrypt:self.nameLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //password
    NSString * password = [AESCrypt encrypt:self.passLabel.text password:[AESCrypt decrypt:app.keycode]];
        
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode",telePhone,@"telno",messageCode,@"msgcode",email,@"email",nickName,@"nickname",password,@"password", nil];
    
    //监控网络状态
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:ZHUCE_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    app.phonenum = self.numLabel.text;
                    app.password = self.passLabel.text;
                    
                    _hudStr = responseObject[@"result"];
                    
                    MBhud(_hudStr);
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self gotoLogin];
                    });
                    
                }else{
                    
                    _hudStr = responseObject[@"result"];
                    MBhud(_hudStr);
                }

            }];
            
        }else{
            
            noWebhud;            
        }
    }];

    
}

- (void)gotoLogin
{
    LoginViewController * login = [[LoginViewController alloc] init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}

@end
