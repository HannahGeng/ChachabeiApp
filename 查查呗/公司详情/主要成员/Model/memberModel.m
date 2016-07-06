//
//  memberModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/23.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "memberModel.h"

@implementation memberModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.surname = dic[@"surname"];
        self.position = dic[@"position"];
        self.sequence = dic[@"sequence"];
    }
    
    return self;
}

@end
