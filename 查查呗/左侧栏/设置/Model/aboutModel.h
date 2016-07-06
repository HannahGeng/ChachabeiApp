//
//  aboutModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutModel : NSObject

/** content */
@property (nonatomic,strong) NSString * content;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

- (instancetype)initWithDiat:(NSDictionary *)dict;

@end
