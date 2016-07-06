//
//  SegmentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SegmentViewController.h"

#define ScreeFrame [UIScreen mainScreen].bounds
@interface SegmentViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
{
    AppDelegate * app;
}

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;

@end

@interface SegmentViewController ()

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    [self initSegment];
    [self initFlipTableView];
}
//设置导航栏
-(void)setNavigationBar
{
    app = [AppDelegate sharedAppDelegate];
    
    [self.navigationItem setHidesBackButton:YES];
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor=LIGHT_BACKGROUND_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title= app.companyName;
    
    //为导航栏添加左侧按钮
    Backbutton;
}
-(void)backButton
{
    [[self navigationController] popViewControllerAnimated:YES];

}
-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, ScreeFrame.size.width, 40) withDataArray:[NSArray arrayWithObjects:@"登记信息",@"股东信息",@"主要成员",@"分支机构",@"变更记录",nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}
-(void)initFlipTableView{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    
    RegistViewController *registVC = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"first"];
    ShareholdViewController *shareholdVC = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    MemberViewController *memberVC = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"third"];
    BranchViewController *branchVC = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"fouth"];
    ChangeViewController *changeVC = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"five"];
    
    
    [self.controllsArray addObject:registVC];
    [self.controllsArray addObject:shareholdVC];
    [self.controllsArray addObject:memberVC];
    [self.controllsArray addObject:branchVC];
    [self.controllsArray addObject:changeVC];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 40, ScreeFrame.size.width, self.view.frame.size.height - 54) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    [self.flipView selectIndex:index];
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    
    [self.segment selectIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
