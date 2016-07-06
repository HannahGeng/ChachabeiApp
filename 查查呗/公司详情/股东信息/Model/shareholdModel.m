//
//  shareholdModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/23.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "shareholdModel.h"

@implementation shareholdModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
         self.shareholder_name = dic[@"shareholder_name"];
        self.shareholder_type = dic[@"shareholder_type"];
    }
    return self;
}

@end
