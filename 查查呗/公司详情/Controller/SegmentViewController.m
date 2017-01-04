//
//  SegmentViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SegmentViewController.h"

#define ScreeFrame [UIScreen mainScreen].bounds
@interface SegmentViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * titleScrollView;

//底部的指示器
@property (nonatomic,strong) UIView * indicatorView;

@property (nonatomic,strong) UIScrollView * contentScrollView;

@property (nonatomic,strong) NSArray * controllArray;

@end

@interface SegmentViewController ()

@end

@implementation SegmentViewController

- (NSArray *)controllArray
{
    if (_controllArray == nil) {
        
        _controllArray = @[
                           @{@"controll":[[RegistViewController alloc] init],
                             @"title":@"登记记录"},
                           @{@"controll":[[ShareholdViewController alloc] init],
                             @"title":@"股东信息"},
                           @{@"controll":[[MemberViewController alloc] init],
                             @"title":@"主要成员"},
                           @{@"controll":[[BranchViewController alloc] init],
                             @"title":@"分支机构"},
                           @{@"controll":[[ChangeViewController alloc] init],
                             @"title":@"变更记录"},
                           ];
    }
    
    return _controllArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置导航栏
    [self setNavigationBar];

    //添加子控制器
    [self setupChildVc];
    
    //添加标题栏
    [self setupTitle];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //标题scrollView
    UIScrollView * titleScrollView = [[UIScrollView alloc] init];
    titleScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    titleScrollView.contentSize = CGSizeMake(400, 0);
    self.titleScrollView = titleScrollView;
    [self.view addSubview:titleScrollView];
    
    //内容scrollView
    UIScrollView * contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = CGRectMake(0, 35, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 35);
    contentScrollView.contentSize = CGSizeMake(5  * [UIScreen mainScreen].bounds.size.width, 0);
    contentScrollView.delegate = self;
    self.contentScrollView = contentScrollView;
    contentScrollView.pagingEnabled = YES;
    [self.view addSubview:contentScrollView];
   
}

//设置导航栏
-(void)setNavigationBar
{
    AppShare;

    SetNavigationBar(app.companyName);
    
    //为导航栏添加左侧按钮
    Backbutton;
}

-(void)backButton
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)setupChildVc
{
    for (int i = 0; i < self.controllArray.count; i++) {
        
        [self addChildViewController:self.controllArray[i][@"controll"]];
        
        self.childViewControllers[i].title =  self.controllArray[i][@"title"];
    }
    
}

- (void)setupTitle
{
    CGFloat labelW = 80;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    CGFloat labelY = 0;
    
    for (NSInteger i = 0; i < 5; i++) {
        
        TitleScrollLabel * label = [[TitleScrollLabel alloc] init];
        label.text = self.childViewControllers[i].title;
        label.textAlignment = NSTextAlignmentCenter;
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        label.tag = i;

        [self.titleScrollView addSubview:label];
        
        if (i == 0) {//最前面的label
            
            label.scale = 1.0;
        }
    }
    
}

- (void)labelClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

//scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    //让对应的顶部标题居中显示
    TitleScrollLabel * label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    
    //左边超出
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    //右边超出
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    //让其他label回到最初的状态
//    for (TitleScrollLabel * otherLabel in self.titleScrollView.subviews) {
        
//        if (otherLabel != label) otherLabel.scale = 0.0;
//    }
    
    //取出需要显示的控制器
    UIViewController * willShowVc = self.childViewControllers[index];
    
    //如果当前位置的位置已经显示过了，就直接回来
    if ([willShowVc isViewLoaded]) return;
    
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    TitleScrollLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    
    TitleScrollLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count - 2) ? nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
    
}

@end
