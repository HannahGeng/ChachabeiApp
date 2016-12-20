//
//  CCBWelcomViewController.m
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import "CCBWelcomViewController.h"

@interface CCBWelcomViewController ()

@end

@implementation CCBWelcomViewController

static NSString * ID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    //注册cell
    [self.collectionView registerClass:[CCBWelcomViewCell class] forCellWithReuseIdentifier:ID];
    
}

- (instancetype)init
{
    //流水布局对象，设置cell的尺寸和位置
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置cell的尺寸
    layout.itemSize = CCBScreenBounds.size;
    
    //设置cell之间的间距
    layout.minimumInteritemSpacing = 0;
    
    //设置行距
    layout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:layout];
}

#pragma mark - UICollectionView有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    
    return 1;
}

#pragma mark - 返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    
    return 4;
}

#pragma mark - 返回每个cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CCBWelcomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString * imageName = [NSString stringWithFormat:@"yindao%ld",indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 3) {
        
        //跳转到核心界面
        KWindow.rootViewController = [[CCBNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        
        CATransition * anim = [CATransition animation];
        anim.duration = 0.5;
        anim.type = @"rippleffect";
        [KWindow.layer addAnimation:anim forKey:nil];
    }
}

@end
