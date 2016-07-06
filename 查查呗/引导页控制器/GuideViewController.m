//
//  GuideViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scrollview;
    UIPageControl *pageControl;
    NSInteger width;
    NSInteger hight;
    UIImageView *_imageView;
    BOOL isOut;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    //假引导页面
    [self makeLaunchView];
}
//假引导页面
-(void)makeLaunchView{
    NSArray *arr=[NSArray arrayWithObjects:@"yindao1",@"yindao2",@"yindao3",@"yindao4", nil];//数组内存放的是我要显示的假引导页面图片
    //通过scrollView 将这些图片添加在上面，从而达到滚动这些图片
    scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, [UIUtils getWindowWidth], [UIUtils getWindowHeight]+20)];
    scrollview.contentSize=CGSizeMake([UIUtils getWindowWidth]*arr.count , [UIUtils getWindowHeight]);
    scrollview.pagingEnabled=YES;
    scrollview.tag=7000;
    scrollview.delegate=self;
    [scrollview setBounces:NO];
    for (int i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*[UIUtils getWindowWidth], 0, [UIUtils getWindowWidth],  [UIUtils getWindowHeight])];
        img.image=[UIImage imageNamed:arr[i]];
        [scrollview addSubview:img];
    }
    
    //滚动时是否水平显示滚动条
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [scrollview setShowsVerticalScrollIndicator:NO];
    //分页显示
    [scrollview setPagingEnabled:YES];
    
    
//    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIUtils getWindowHeight]-50, [UIUtils getWindowWidth], 20)];
//    [pageControl setBackgroundColor:[UIColor clearColor]];
//    pageControl.currentPage = 0;
//    pageControl.numberOfPages = 4;
//    
//    [pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:scrollview];
//    [self.view addSubview:pageControl];
}
- (void) click{
//    NSLog(@"xxx");
}
#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑了30 的时候就做下一个动作
    if (scrollView.contentOffset.x>3*320-10) {
        
        isOut=YES;//这是我声明的一个全局变量Bool 类型的，初始值为no，当达到我需求的条件时将值改为yes
        
    }
}
//停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index= scrollview.contentOffset.x/[UIUtils getWindowWidth];
    [pageControl setCurrentPage:index];
    
    //判断isout为真 就要进入主界面了
    if (isOut) {
        //这里添加了一个动画，（可根据个人喜好）
        [UIView animateWithDuration:2.0 animations:^{
            scrollView.alpha=0;//让scrollview 渐变消失
            
        }completion:^(BOOL finished) {
            [scrollView  removeFromSuperview];//将scrollView移除
            [self gotoMain];//进入主界面
                        
        } ];
    }
}

//去主页
-(void)gotoMain{
    
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"viewController" object:nil];
    
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    [defau setObject:@"2" forKey:@"first"];
    [defau synchronize];
    
    ViewController *viewController=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:viewController animated:NO];
}

@end
