//
//  CommentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/1.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
{
    NSString * _uid;
    NSString * _cid;
    NSString * _platform;
    NSString * _environment;
    NSString * _development;
    NSString * _culture;
    NSString * _honesty;
    NSString * _reputation;
    NSString * _keycode;
    NSString * _request;
    AppDelegate * app;
    MBProgressHUD * mbHud;

}

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UISlider *slider4;
@property (weak, nonatomic) IBOutlet UISlider *slider5;
@property (weak, nonatomic) IBOutlet UISlider *slider6;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (nonatomic,assign)CGFloat percent1;
@property (nonatomic,assign)CGFloat percent2;
@property (nonatomic,assign)CGFloat percent3;
@property (nonatomic,assign)CGFloat percent4;
@property (nonatomic,assign)CGFloat percent5;
@property (nonatomic,assign)CGFloat percent6;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    //设置导航栏的颜色
    SetNavigationBar(@"评论");
    
    //为导航栏添加左侧按钮
    Backbutton;
}
-(void)backButton
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

//添加内容视图
-(void)addContentView
{
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"app30.png"];
    [_slider1 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider1 addTarget:self action:@selector(sliderValueChanged1:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider1];
    
    [_slider2 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider2 addTarget:self action:@selector(sliderValueChanged2:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider2];
    
    
    [_slider3 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider3 addTarget:self action:@selector(sliderValueChanged3:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider3];
    
    
    [_slider4 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider4 addTarget:self action:@selector(sliderValueChanged4:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider4];
    
    
    [_slider5 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider5 addTarget:self action:@selector(sliderValueChanged5:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider5];
    
    
    [_slider6 setThumbImage:thumbImage forState:UIControlStateNormal];
    [_slider6 addTarget:self action:@selector(sliderValueChanged6:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider6];
}

-(void)sliderValueChanged1:(UISlider *)slide{
    self.percent1 = slide.value;
}

-(void)sliderValueChanged2:(UISlider *)slide{

    self.percent2 = slide.value;
}

-(void)sliderValueChanged3:(UISlider *)slide{
    self.percent3 = slide.value;
}

-(void)sliderValueChanged4:(UISlider *)slide{
    self.percent4 = slide.value;
}

-(void)sliderValueChanged5:(UISlider *)slide{
    self.percent5 = slide.value;
}

-(void)sliderValueChanged6:(UISlider *)slide{
    self.percent6 = slide.value;
}

-(void)setPercent1:(CGFloat)percent1{
    _percent1 = percent1;
    _slider1.value = percent1;
    
    int num=(int)(percent1);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label1.text=array[0];
    }
    if (1<=num&&num<2) {
        _label1.text=array[1];
    }
    if (2<=num&&num<3) {
        _label1.text=array[2];
    }
    if (3<=num&&num<4) {
        _label1.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label1.text=array[4];
    }
}
-(void)setPercent2:(CGFloat)percent2{
    _percent2 = percent2;
    _slider2.value = percent2;
    
    int num=(int)(percent2);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label2.text=array[0];
    }
    if (1<=num&&num<2) {
        _label2.text=array[1];
    }
    if (2<=num&&num<3) {
        _label2.text=array[2];
    }
    if (3<=num&&num<4) {
        _label2.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label2.text=array[4];
    }
}
-(void)setPercent3:(CGFloat)percent3{
    _percent3 = percent3;
    _slider3.value = percent3;
    
    int num=(int)(percent3);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label3.text=array[0];
    }
    if (1<=num&&num<2) {
        _label3.text=array[1];
    }
    if (2<=num&&num<3) {
        _label3.text=array[2];
    }
    if (3<=num&&num<4) {
        _label3.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label3.text=array[4];
    }
}
-(void)setPercent4:(CGFloat)percent4{
    _percent4 = percent4;
    _slider4.value = percent4;
    
    int num=(int)(percent4);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label4.text=array[0];
    }
    if (1<=num&&num<2) {
        _label4.text=array[1];
    }
    if (2<=num&&num<3) {
        _label4.text=array[2];
    }
    if (3<=num&&num<4) {
        _label4.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label4.text=array[4];
    }
}
-(void)setPercent5:(CGFloat)percent5{
    _percent5 = percent5;
    _slider5.value = percent5;
    
    int num=(int)(percent5);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label5.text=array[0];
    }
    if (1<=num&&num<2) {
        _label5.text=array[1];
    }
    if (2<=num&&num<3) {
        _label5.text=array[2];
    }
    if (3<=num&&num<4) {
        _label5.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label5.text=array[4];
    }
}
-(void)setPercent6:(CGFloat)percent6{
    _percent6 = percent6;
    _slider6.value = percent6;
    
    int num=(int)(percent6);
    NSArray *array=[NSArray arrayWithObjects:@"差",@"较差",@"一般",@"较好",@"好",nil];
    
    if (0<=num&&num<1) {
        _label6.text=array[0];
    }
    if (1<=num&&num<2) {
        _label6.text=array[1];
    }
    if (2<=num&&num<3) {
        _label6.text=array[2];
    }
    if (3<=num&&num<4) {
        _label6.text=array[3];
    }
    if (4<=num&&num<=5) {
        _label6.text=array[4];
    }
}

- (IBAction)submitClick:(UIButton *)sender {
    
    app = [AppDelegate sharedAppDelegate];
    _uid = app.uid;
    _keycode = app.keycode;
    _request = app.request;
    _cid = [AESCrypt encrypt:app.companyID password:[AESCrypt decrypt:_keycode password:nil]];

//    NSLog(@"keycode:%@",app.loginKeycode);
//    NSLog(@"\nuid:%@\ncid:%@\nrequest:%@\nplatform:%.0f\nenviroment:%.0f\ndelvelopment:%.0f\nculture:%.0f\nhonest:%.0f\nreputation:%.0f",_uid,app.companyID,_request,_percent1,_percent2,_percent3,_percent4,_percent5,_percent6);
    
    NSString * percent1 = [NSString stringWithFormat:@"%.f",_percent1];
    NSString * percent2 = [NSString stringWithFormat:@"%.f",_percent2];
    NSString * percent3 = [NSString stringWithFormat:@"%.f",_percent3];
    NSString * percent4 = [NSString stringWithFormat:@"%.f",_percent4];
    NSString * percent5 = [NSString stringWithFormat:@"%.f",_percent5];
    NSString * percent6 = [NSString stringWithFormat:@"%.f",_percent6];

    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_cid,@"cid",_request,@"request",percent1,@"platform",percent2,@"environment",percent3,@"development",percent4,@"culture",percent5,@"honest",percent6,@"reputation", nil];
    
    [[HTTPSessionManager sharedManager] POST:CompanyComment_URL parameters:pDic result:^(id responseObject, NSError *error) {
        
        app.request = responseObject[@"response"];
        
        [SaveTool setObject:responseObject[@"result"] forKey:@"commentResult"];
        
        if ([responseObject[@"status"] integerValue] == -3) {
            
            MBhud(responseObject[@"result"]);
            
        }else{
            
            DrawingViewController *drawingVC=[[DrawingViewController alloc]init];
            UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:drawingVC];
            [self presentViewController:naviController animated:YES completion:nil];
            
        }

    }];
    
}

@end
