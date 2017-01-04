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

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAll];
    
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

    [self showSimpleTopologyDemo];
    [_echartsView loadEcharts];
}

- (void)showSimpleTopologyDemo {
    
    NSString *basicPieJson = @"{\"title\":{\"text\":\"人物关系：乔布斯\",\"subtext\":\"数据来自人立方\",\"x\":\"right\",\"y\":\"bottom\"},\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{a} : {b}\"},\"toolbox\":{\"show\":true,\"feature\":{\"restore\":{\"show\":true},\"magicType\":{\"show\":true,\"type\":[\"force\",\"chord\"]},\"saveAsImage\":{\"show\":true}}},\"legend\":{\"x\":\"left\",\"data\":[\"家人\",\"朋友\"]},\"series\":[{\"type\":\"force\",\"name\":\"人物关系\",\"ribbonType\":false,\"categories\":[{\"name\":\"人物\"},{\"name\":\"家人\"},{\"name\":\"朋友\"}],\"itemStyle\":{\"normal\":{\"label\":{\"show\":true,\"textStyle\":{\"color\":\"#333\"}},\"nodeStyle\":{\"brushType\":\"both\",\"borderColor\":\"rgba(255,215,0,0.4)\",\"borderWidth\":1},\"linkStyle\":{\"type\":\"curve\"}},\"emphasis\":{\"label\":{\"show\":false},\"nodeStyle\":{},\"linkStyle\":{}}},\"useWorker\":false,\"minRadius\":15,\"maxRadius\":25,\"gravity\":1.1,\"scaling\":1.1,\"roam\":\"move\",\"nodes\":[{\"category\":0,\"name\":\"乔布斯\",\"value\":10,\"label\":\"乔布斯\\n（主要）\"},{\"category\":1,\"name\":\"丽萨-乔布斯\",\"value\":2},{\"category\":1,\"name\":\"保罗-乔布斯\",\"value\":3},{\"category\":1,\"name\":\"克拉拉-乔布斯\",\"value\":3},{\"category\":1,\"name\":\"劳伦-鲍威尔\",\"value\":7},{\"category\":2,\"name\":\"史蒂夫-沃兹尼艾克\",\"value\":5},{\"category\":2,\"name\":\"奥巴马\",\"value\":8},{\"category\":2,\"name\":\"比尔-盖茨\",\"value\":9},{\"category\":2,\"name\":\"乔纳森-艾夫\",\"value\":4},{\"category\":2,\"name\":\"蒂姆-库克\",\"value\":4},{\"category\":2,\"name\":\"龙-韦恩\",\"value\":1}],\"links\":[{\"source\":\"丽萨-乔布斯\",\"target\":\"乔布斯\",\"weight\":1,\"name\":\"女儿\"},{\"source\":\"保罗-乔布斯\",\"target\":\"乔布斯\",\"weight\":2,\"name\":\"父亲\"},{\"source\":\"克拉拉-乔布斯\",\"target\":\"乔布斯\",\"weight\":1,\"name\":\"母亲\"},{\"source\":\"劳伦-鲍威尔\",\"target\":\"乔布斯\",\"weight\":2},{\"source\":\"史蒂夫-沃兹尼艾克\",\"target\":\"乔布斯\",\"weight\":3,\"name\":\"合伙人\"},{\"source\":\"奥巴马\",\"target\":\"乔布斯\",\"weight\":1},{\"source\":\"比尔-盖茨\",\"target\":\"乔布斯\",\"weight\":6,\"name\":\"竞争对手\"},{\"source\":\"乔纳森-艾夫\",\"target\":\"乔布斯\",\"weight\":1,\"name\":\"爱将\"},{\"source\":\"蒂姆-库克\",\"target\":\"乔布斯\",\"weight\":1},{\"source\":\"龙-韦恩\",\"target\":\"乔布斯\",\"weight\":1},{\"source\":\"克拉拉-乔布斯\",\"target\":\"保罗-乔布斯\",\"weight\":1},{\"source\":\"奥巴马\",\"target\":\"保罗-乔布斯\",\"weight\":1},{\"source\":\"奥巴马\",\"target\":\"克拉拉-乔布斯\",\"weight\":1},{\"source\":\"奥巴马\",\"target\":\"劳伦-鲍威尔\",\"weight\":1},{\"source\":\"奥巴马\",\"target\":\"史蒂夫-沃兹尼艾克\",\"weight\":1},{\"source\":\"比尔-盖茨\",\"target\":\"奥巴马\",\"weight\":6},{\"source\":\"比尔-盖茨\",\"target\":\"克拉拉-乔布斯\",\"weight\":1},{\"source\":\"蒂姆-库克\",\"target\":\"奥巴马\",\"weight\":1}]}]}";
    
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",jsonDic);

    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    
    [_echartsView setOption:option];
}

@end
