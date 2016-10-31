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
        
        [self labelWithLabel:_label1 Frame:CGRectMake((([UIUtils getWindowWidth] - 260)/ 2 - 55) / 2 + 20, ([UIUtils getWindowHeight]-128)/2, 55, 20) text:@"前景趋势" tag:1];
    }else{
        
        [self labelWithLabel:_label1 Frame:CGRectMake((([UIUtils getWindowWidth] - 260)/ 2 - 55) / 2, ([UIUtils getWindowHeight]-128)/2, 55, 20) text:@"前景趋势" tag:1];
    }
    
    [self labelWithLabel:_label2 Frame:CGRectMake([UIUtils getWindowWidth]-58, ([UIUtils getWindowHeight]-128)/2, 55, 20) text:@"企业诚信" tag:2];
    
    [self labelWithLabel:_label3 Frame:CGRectMake([UIUtils getWindowWidth]/3-60, ([UIUtils getWindowHeight]-128)/4, 60, 20) text:@"发展平台" tag:3];
    
    [self labelWithLabel:_label4 Frame:CGRectMake([UIUtils getWindowWidth]/3*2, ([UIUtils getWindowHeight]-128)/4, 60, 20) text:@"工作环境" tag:4];
    
    [self labelWithLabel:_label5 Frame:CGRectMake([UIUtils getWindowWidth]/3-60, ([UIUtils getWindowHeight]-128)/4 * 3 - 20, 60, 20) text:@"企业文化" tag:5];
    
    [self labelWithLabel:_label6 Frame:CGRectMake([UIUtils getWindowWidth]/3*2, ([UIUtils getWindowHeight]-128)/4 * 3-20, 60, 20) text:@"社会声誉" tag:6];
}

- (void)labelWithLabel:(UILabel *)label Frame:(CGRect)frame text:(NSString *)text tag:(int)tag
{
    label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.tag = tag;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius=10;
    label.backgroundColor=DARK_GREEN_COLOR;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
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
