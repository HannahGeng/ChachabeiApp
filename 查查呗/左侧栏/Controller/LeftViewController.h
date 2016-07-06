//
//  LeftViewController.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SideBarMenuViewController;

@interface LeftViewController : UIViewController

@property (nonatomic, assign) SideBarMenuViewController *sideBarMenuVC;

//展示相应的controller
- (void)showViewControllerWithIndex:(int)index;

@end
