//
//  attentionModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "attentionModel.h"

@implementation attentionModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    AppDelegate * app = [AppDelegate sharedAppDelegate];
    if (self = [super init]) {
        self.cname = dictionary[@"cname"];
        self.province_name = app.province;
    }
    return self;
}

@end
