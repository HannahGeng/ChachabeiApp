//
//  ChartViewController.m
//  企业图谱
//
//  Created by zdzx-008 on 2016/12/7.
//  Copyright © 2016年 zdzx-008. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController ()

@property (weak, nonatomic) IBOutlet PYEchartsView *echartsView;

@property (nonatomic,strong) NSArray * stocks;

@end

@implementation ChartViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initAll];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;
    
    self.stocks = app.companyDetailContent[@"stockInfo"];
    
    //设置导航栏
    [self setNavigationBar];

}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"企业图谱");
    
    //为导航栏添加左侧按钮
    Backbutton;
    
}

-(void)backButton
{
    MainViewController * vc = [[MainViewController alloc] init];
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[vc class]]) {
        
        //发送通知
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"homeView" object:nil];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) initAll {

    [self showNonRibbonChordDemo];
    
    [_echartsView loadEcharts];

}

- (void)showNonRibbonChordDemo {
    
    AppShare;
    
    PYOption *option = [[PYOption alloc] init];
    
    option.title = [[PYTitle alloc] init];
    
    option.tooltip = [[PYTooltip alloc] init];
    option.tooltip.trigger = PYTooltipTriggerItem;
    option.tooltip.formatter = @"(function (params) {if (params.indicator2) {return params.indicator2 + \' \' + params.name + \' \' + params.indicator;} else {return params.name}})";
    option.toolbox = [[PYToolbox alloc] init];
    option.toolbox.show = YES;
    option.toolbox.feature = [[PYToolboxFeature alloc] init];
    option.toolbox.feature.restore = [[PYToolboxFeatureRestore alloc] init];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.magicType = [[PYToolboxFeatureMagicType alloc] init];
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[PYSeriesTypeForce, PYSeriesTypeChord];
    option.toolbox.feature.restore = [[PYToolboxFeatureRestore alloc] init];
    option.toolbox.feature.restore.show = YES;
    
    option.legend = [[PYLegend alloc] init];
    option.legend.x = @"left";
    option.legend.data = @[app.companyName];
    
    PYChordSeries *series = [[PYChordSeries alloc] init];
    series.type = PYSeriesTypeChord;
    series.sort = PYSortAscending;
    series.sortSub = PYSortDescending;
    series.ribbonType = NO;
    series.radius = @"60%";
    series.itemStyle = [[PYItemStyle alloc] init];
    series.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series.itemStyle.normal.label = [[PYLabel alloc] init];
    series.itemStyle.normal.label.rotate = YES;
    series.minRadius = @7;
    series.maxRadius = @10;
    
    NSMutableArray * nameArr = [NSMutableArray array];
    NSMutableArray * seriesArr = [NSMutableArray array];
    
    [nameArr addObject:@{@"name":app.companyName}];

    for (int i = 0; i < self.stocks.count; i++) {
        
        NSString * nameStr = self.stocks[i][@"stock_name"];
        
        NSDictionary * dic = [NSDictionary dictionaryWithObject:nameStr forKey:@"name"];
        
        NSMutableDictionary * seriesDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:app.companyName,@"target",self.stocks[i][@"stock_name"],@"source",@0.5,@"weight", nil];
        
        [seriesArr addObject:seriesDic];
        
        [nameArr addObject:dic];
    }
        
    series.nodes = [[NSMutableArray alloc] initWithArray:nameArr];
    
    series.links = [[NSMutableArray alloc] initWithArray:seriesArr];
    
    option.series = [[NSMutableArray alloc] initWithArray:@[series]];
    
    [_echartsView setOption:option];
}

@end
