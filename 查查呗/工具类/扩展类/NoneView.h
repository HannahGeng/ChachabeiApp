//
//  NoneView.h
//  查查呗
//
//  Created by zdzx-008 on 16/10/10.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneView : UIView

+ (instancetype)showNoneView;

- (instancetype)showInPoint:(CGPoint)point title:(NSString *)title;

@end
