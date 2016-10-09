//
//  ForgetPasswordViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/25.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    UIButton * _verificationButton;
    NSString * _isForgetpass;//是否忘记密码
    NSString * _messageStr;//加密的验证码
    NSString * _newPass;//加密的密码
    NSString * _hudStr;
    MBProgressHUD * mbHud;

}

@property (weak, nonatomic) IBOutlet UIButton *timeButton;

/** 手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumLabel;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *messageLabel;
/** 设置密码 */
@property (weak, nonatomic) IBOutlet UITextField *setPassLabel;
/** 确认密码 */
@property (weak, nonatomic) IBOutlet UITextField *confirmPassLabel;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationBar];
    
    //设置注册界面样式
    [self setUIStyle];
}

- (void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"找回密码");
    
    //为导航栏添加左侧按钮
    Backbutton;
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUIStyle
{
    _verificationButton.layer.masksToBounds=YES;
    _verificationButton.layer.cornerRadius=5;
    
    _timeButton.layer.cornerRadius = 5;
}

- (IBAction)timeClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    AppShare;
    
    //手机号加密
    NSString * telePhone = [AESCrypt encrypt:self.phoneNumLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    _isForgetpass = @"1";
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode",telePhone,@"telno",_isForgetpass,@"is_forgetpass", nil];
    
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

- (void)startTime
{
    
    if (_messageLabel.text.length != 0) {
        [_messageLabel.text stringByReplacingOccurrencesOfString:_messageLabel.text withString:@""];
    }
    
    if (_phoneNumLabel.text.length != 0) {
        
        [self.view endEditing:YES];

        MBhud(_hudStr);
        
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
                    //NSLog(@"____%@",strTime);
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
        
    }else if (_phoneNumLabel.text.length == 0){
     
        MBhud(@"手机号为空");
        
    }
}

#define mark - textfield可输入字数限制
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1) {
        
        NSString * phoneString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (phoneString.length > 11 && range.length != 1) {
            _phoneNumLabel.text = [phoneString substringToIndex:11];
            return NO;
        }
    }else if (textField.tag == 2 ){
            NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
            if (passString.length > 16 && range.length != 1) {
                _setPassLabel.text = [passString substringToIndex:16];
                return NO;
            }
    }else if(textField.tag == 3){
        
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 16 && range.length != 1) {
            _confirmPassLabel.text = [passString substringToIndex:16];
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

- (IBAction)confirmClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    AppShare;
    
    //手机号加密
    NSString * telePhone = [AESCrypt encrypt:self.phoneNumLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //验证码加密
    _messageStr = [AESCrypt encrypt:_messageLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    //密码加密
    _newPass = [AESCrypt encrypt:_setPassLabel.text password:[AESCrypt decrypt:app.keycode]];
    
    _isForgetpass = @"1";
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.keycode,@"keycode",telePhone,@"telno",_messageStr,@"msgcode",_newPass,@"newpass", nil];
    
    if (![_setPassLabel.text isEqualToString:_confirmPassLabel.text]) {
        
        MBhud(@"密码输入不一致");

    }else{
        
        //监控网络状态
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:forgetPass_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    _hudStr = responseObject[@"result"];
                    
                    MBhud(_hudStr)
                    
                    if ([_hudStr isEqualToString:@"密码更新成功"]) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"deletePass" object:nil];
                        });
                        
                    }

                }];
        
            }else{
                
                noWebhud;
                
            }
        }];

    
    }
    
}

@end
