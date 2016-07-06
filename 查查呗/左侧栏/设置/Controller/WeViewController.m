//
//  WeViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/12.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "WeViewController.h"

@interface WeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *urlButton;
@property (weak, nonatomic) IBOutlet UIButton *telephoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation WeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    [_urlButton addTarget:self action:@selector(urlButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_telephoneButton addTarget:self action:@selector(telephoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_emailButton addTarget:self action:@selector(emailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *string=@"      查查呗是深圳中鼎职信旗下的一款企业征信产品，为用户提供快速查询企业工商信息、企业信用评级、授权记录、商标信息、失信记录、关联企业信息、招聘信息等服务。通过多模式查询，多选项筛选，以及多维度评价展示，让查询结果更准确，查询内容更详尽！是泛金融，泛投资，泛法律和泛商务（如销售、采购）相关人士的首选工具！";
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string length])];
    [_contentLabel setAttributedText:attributedString1];
    [_contentLabel sizeToFit];
    
}
//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"关于我们";
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)urlButtonClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.4000520856.com"]];
}
-(void)telephoneButtonClick
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://4000520856"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
-(void)emailButtonClick{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://798391466@qq.com"]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
