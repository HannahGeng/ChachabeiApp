//
//  AdviceViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()<UITextViewDelegate>
{
    UILabel *_placeholderLabel;
    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置背景颜色
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
    self.contentTextView.layer.borderColor = LIGHT_GREY_COLOR.CGColor;
    self.contentTextView.layer.borderWidth = 2;
    self.contentTextView.hidden=NO;
    self.contentTextView.delegate=self;
    
    _placeholderLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 7, 280, 20)];
    _placeholderLabel.text = @"请详细描述你的问题建议，最多300字。";
    _placeholderLabel.textColor=[UIColor lightGrayColor];
    _placeholderLabel.font=[UIFont systemFontOfSize:15];
    _placeholderLabel.enabled = NO;//lable必须设置为不可用
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.contentTextView addSubview:_placeholderLabel];
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"问题建议");
    
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
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.contentTextView.text= textView.text;
    if (textView.text.length == 0) {
        _placeholderLabel.text = @"请详细描述你的问题建议，最多300字。";
    }else{
        _placeholderLabel.text = @"";
    }
}

- (IBAction)submitSuggest:(UIButton *)sender {
    
    [self.view endEditing:YES];
    AppShare;
    
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",[AESCrypt encrypt:self.contentTextView.text password:[AESCrypt decrypt:app.loginKeycode]],@"content", nil];

    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:Home_Suggest_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                app.request = responseObject[@"response"];
                
            }];
            
        }else{
            
            noWebhud;

        }
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
