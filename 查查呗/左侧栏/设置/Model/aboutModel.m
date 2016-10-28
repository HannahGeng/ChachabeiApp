//
//  aboutModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "aboutModel.h"

@implementation aboutModel

- (instancetype)initWithDiat:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.content = dict[@"content"];
    }
    
    return self;
}

@end
