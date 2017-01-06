//
//  CCBNavigationController.m
//  查查呗
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "CCBNavigationController.h"

@interface CCBNavigationController ()

@end

@implementation CCBNavigationController

+ (void)initialize
{    
    UINavigationBar * bar = [UINavigationBar appearance];
    bar.barTintColor = LIGHT_BACKGROUND_COLOR;
    
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    AppShare;
    
    if (self.childViewControllers.count > 0) {
    
        [self.navigationBar setHidden:NO];
        
        if (![viewController isKindOfClass:[CCBLeftViewController class]] && ![viewController isKindOfClass:[MainViewController class]]) {
            
            [app.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }
        UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 20, 20);
        [leftBtn setImage:[UIImage imageNamed:@"app02"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
