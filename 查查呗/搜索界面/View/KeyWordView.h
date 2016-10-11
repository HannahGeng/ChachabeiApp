//
//  KeyWordView.h
//  查查呗
//
//  Created by zdzx-008 on 16/10/11.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyWordView : UIButton

@property (weak, nonatomic) IBOutlet UILabel *keywordLabel;
+ (instancetype)show;
+ (instancetype)showInPoint:(CGPoint)point;
+ (void)hide;

@end
