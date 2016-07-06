//
//  BranchModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/24.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BranchModel : NSObject

@property (nonatomic,strong) NSString * company_name;

@property (nonatomic,strong) NSString * regist_no;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
