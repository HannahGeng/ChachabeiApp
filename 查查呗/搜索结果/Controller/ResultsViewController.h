//
//  ResultsViewController.h
//  查查呗
//
//  Created by zdzx-008 on 15/12/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityName)(NSString *cityname);

@interface ResultsViewController : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;

@end
