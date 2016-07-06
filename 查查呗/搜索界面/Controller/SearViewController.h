//
//  SearViewController.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class attentionModel;

typedef void(^ReturnCityName)(NSString *cityname);

@interface SearViewController : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

@property (nonatomic,strong) attentionModel * attention;

- (void)returnText:(ReturnCityName)block;

@end
