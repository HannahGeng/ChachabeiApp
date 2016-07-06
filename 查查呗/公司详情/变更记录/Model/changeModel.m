//
//  changeModel.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/27.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "changeModel.h"

@implementation changeModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.change_item = dic[@"change_item"];
        self.after_change = dic[@"after_change"];
        self.change_date = dic[@"change_date"];
        self.changecompany_type = dic[@"changecompany_type"];
        self.before_change = dic[@"before_change"];
        self.regist_no = dic[@"regist_no"];
    }
    
    return self;
}

@end
