//
//  CCBBaseViewController.h
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBBaseViewController : UIViewController

- (void)pushNewViewController:(UIViewController *)newViewController;

//设置带图片的做导航栏按钮并且回掉方法
- (void)LeftBarButton;

@end
