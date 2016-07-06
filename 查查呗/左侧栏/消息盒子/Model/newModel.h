//
//  newModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/25.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newModel : NSObject

/** title */
@property (nonatomic,strong) NSString * title;

/** 时间 */
@property (nonatomic,strong) NSString * msgtime;

/** 内容 */
@property (nonatomic,strong) NSString * content;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
