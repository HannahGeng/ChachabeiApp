//
//  DrawingViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/2.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "DrawingViewController.h"

@interface DrawingViewController ()
{
    CustomView *_customView;
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    UILabel *_label6;

}
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    //添加内容视图
    [self addContentView];
    
    AppShare;
    
    NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
    NSDictionary * commentResult = [defau dictionaryForKey:@"commentResult"];
    
    NSDictionary *valueDictionary = @{@"企业诚信": commentResult[@"honesty"],
                                      @"社会声誉": commentResult[@"reputation"],
                                      @"企业文化" : commentResult[@"culture"],
                                      @"前景趋势" : commentResult[@"development"],
                                      @"发展平台": commentResult[@"platform"],
                                      @"工作环境" : commentResult[@"environment"],
                                      };
    

    _customView = [[CustomView alloc] initWithFrame:self.view.frame valueDictionary:valueDictionary];
    [_customView setMaxValue:9];
    [self.view addSubview:_customView];
    
    self.companyName.text = app.companyName;
    
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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)homeButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
    
}

//添加内容视图
-(void)addContentView
{
    if ([UIUtils getWindowWidth] < 350) {
        _label1=[[UILabel alloc]initWithFrame:CGRectMake((([UIUtils getWindowWidth] - 260)/ 2 - 55) / 2 + 20, ([UIUtils getWindowHeight]-128)/2, 55, 20)];
    }else{
         _label1=[[UILabel alloc]initWithFrame:CGRectMake((([UIUtils getWindowWidth] - 260)/ 2 - 55) / 2, ([UIUtils getWindowHeight]-128)/2, 55, 20)];
    }
    
    _label1.text=@"前景趋势";
    _label1.tag = 1;
    _label1.textAlignment=NSTextAlignmentCenter;
    _label1.textColor=[UIColor whiteColor];
    _label1.layer.masksToBounds = YES;
    _label1.layer.cornerRadius=10;
    _label1.backgroundColor=ORANGE_COLOR;
    _label1.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label1];
    
    _label2=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-58, ([UIUtils getWindowHeight]-128)/2, 55, 20)];
    _label2.text=@"企业诚信";
    _label2.tag = 2;
    _label2.textAlignment=NSTextAlignmentCenter;
    _label2.textColor=[UIColor whiteColor];
    _label2.layer.masksToBounds = YES;
    _label2.layer.cornerRadius=10;
    _label2.backgroundColor=DARK_RED_COLOR;
    _label2.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label2];
    
    _label3=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/3-60, ([UIUtils getWindowHeight]-128)/4, 60, 20)];
    _label3.text=@"发展平台";
    _label3.tag = 3;
    _label3.textAlignment=NSTextAlignmentCenter;
    _label3.textColor=[UIColor whiteColor];
    _label3.layer.masksToBounds = YES;
    _label3.layer.cornerRadius=10;
    _label3.backgroundColor=LIGHT_BLUE_COLOR;
    _label3.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label3];
    
    _label4=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/3*2, ([UIUtils getWindowHeight]-128)/4, 60, 20)];
    _label4.text=@"工作环境";
    _label4.tag = 4;
    _label4.textAlignment=NSTextAlignmentCenter;
    _label4.textColor=[UIColor whiteColor];
    _label4.layer.masksToBounds = YES;
    _label4.layer.cornerRadius=10;
    _label4.backgroundColor=GREEN_COLOR;
    _label4.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label4];
    
    _label5=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/3-60, ([UIUtils getWindowHeight]-128)/4 * 3 - 20, 60, 20)];
    _label5.text=@"企业文化";
    _label5.tag = 5;
    _label5.textAlignment=NSTextAlignmentCenter;
    _label5.textColor=[UIColor whiteColor];
    _label5.layer.masksToBounds = YES;
    _label5.layer.cornerRadius=10;
    _label5.backgroundColor=LIGHT_BACKGROUND_COLOR;
    _label5.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label5];

    _label6=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]/3*2, ([UIUtils getWindowHeight]-128)/4 * 3-20, 60, 20)];
    _label6.text=@"社会声誉";
    _label6.tag = 6;
    _label6.textAlignment=NSTextAlignmentCenter;
    _label6.textColor=[UIColor whiteColor];
    _label6.layer.masksToBounds = YES;
    _label6.layer.cornerRadius=10;
    _label6.backgroundColor=DARK_GREEN_COLOR;
    _label6.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:_label6];

}

- (IBAction)shareButton:(UIButton *)sender {
    
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

}

@end
