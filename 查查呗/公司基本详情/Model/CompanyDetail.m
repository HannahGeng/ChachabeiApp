//
//  CompanyDetail.m
//  查查呗
//
//  Created by zdzx-008 on 16/4/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "CompanyDetail.h"

@implementation CompanyDetail

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        self.company_name = dictionary[@"ent_name"];
        self.regist_no = dictionary[@"reg_no"];
        self.registdepartment = dictionary[@"reg_dept"];
        self.establish_data = dictionary[@"create_date"];
        self.company_type = dictionary[@"ent_type"];
        self.scope = dictionary[@"scope"];
        self.address = dictionary[@"address"];
        self.corporation = dictionary[@"corporation"];
        self.capital = dictionary[@"reg_capital"];
        self.stockholder = dictionary[@"stockInfo"];
        self.member = dictionary[@"member"];
        self.branch = dictionary[@"branch"];
        self.modify = dictionary[@"modify"];
        self.busniss_alloted_time_later = dictionary[@"busniss_alloted_time_later"];
        self.busniss_alloted_time_start = dictionary[@"busniss_alloted_time_start"];
    }
    
    return self;
}

@end
