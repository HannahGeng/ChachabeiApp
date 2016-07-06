//
//  newModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/25.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "newModel.h"

@implementation newModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.content = dic[@"content"];
        self.msgtime = dic[@"msgtime"];
    }
    return self;
}

@end
