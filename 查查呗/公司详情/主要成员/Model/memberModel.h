//
//  memberModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/23.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface memberModel : NSObject

/** 职称 */
@property (nonatomic,strong) NSString * position;

/** 姓名 */
@property (nonatomic,strong) NSString * surname;

/** 编号 */
@property (nonatomic,strong) NSString * sequence;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
