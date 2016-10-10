//
//  BranchModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/24.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "BranchModel.h"

@implementation BranchModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.company_name = dic[@"ent_name"];
        self.regist_no = dic[@"reg_no"];
    }
    return self;
}

@end
