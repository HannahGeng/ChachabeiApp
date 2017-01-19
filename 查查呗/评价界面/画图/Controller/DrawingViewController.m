//
//  DrawingViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/2.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "DrawingViewController.h"

@interface DrawingViewController ()<ZFRadarChartDataSource,ZFRadarChartDelegate>
{
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    UILabel *_label6;
}

@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (strong, nonatomic) ZFRadarChart *radarChart;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *botLabel;

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
    
//    _customView = [[CustomView alloc] initWithFrame:self.view.frame valueDictionary:valueDictionary];
//    [_customView setMaxValue:9];
//    [self.view addSubview:_customView];
    
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
    AppShare;
    
    self.radarChart = [[ZFRadarChart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCREEN_WIDTH, CGRectGetMaxY(self.botLabel.frame) - 2 * CGRectGetMaxY(self.titleView.frame) - 20)];
    self.radarChart.dataSource = self;
    self.radarChart.delegate = self;
    self.radarChart.itemFont = [UIFont systemFontOfSize:12.f];
    self.radarChart.valueFont = [UIFont systemFontOfSize:12.f];
    self.radarChart.polygonLineWidth = 2.f;
    self.radarChart.valueType = kValueTypeDecimal;
    self.radarChart.valueTextColor = ZFOrange;
    [self.view addSubview:self.radarChart];
    
    [self.radarChart strokePath];
    
    self.companyName.text = app.companyName;
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

//ZFRadarChartDataSource
- (NSArray *)itemArrayInRadarChart:(ZFRadarChart *)radarChart
{
    return @[@"企业诚信",@"企业文化",@"前景趋势",@"发展平台", @"工作环境", @"社会声誉"];
}

- (NSArray *)valueArrayInRadarChart:(ZFRadarChart *)radarChart
{
    NSUserDefaults * defau = [NSUserDefaults standardUserDefaults];
    NSDictionary * commentResult = [defau dictionaryForKey:@"commentResult"];

//    return @[commentResult[@"honesty"], commentResult[@"reputation"], commentResult[@"culture"], commentResult[@"development"], commentResult[@"platform"], commentResult[@"environment"]];
    
    return nil;
}

- (CGFloat)maxValueInRadarChart:(ZFRadarChart *)radarChart{
    return 10.f;
}

//ZFRadarChartDelegate
- (CGFloat)radiusForRadarChart:(ZFRadarChart *)radarChart
{
    return (SCREEN_WIDTH - 100) / 2;
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
