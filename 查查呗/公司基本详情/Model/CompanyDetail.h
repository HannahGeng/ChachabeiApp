//
//  CompanyDetail.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIkit/UIKit.h>

@interface CompanyDetail : NSObject

/** 公司名 */
@property (nonatomic,strong) NSString * company_name;

/** 注册号 */
@property (nonatomic,strong) NSString * regist_no;

/** 注册时间 */
@property (nonatomic,strong) NSString * registration_time;

/** 公司类型 */
@property (nonatomic,strong) NSString * company_type;

/** 公司组织 */
@property (nonatomic,strong) NSString * company_from;

/** 成立时间 */
@property (nonatomic,strong) NSString * establish_data;

/** 注册资金 */
@property (nonatomic,strong) NSString * capital;

/** 经营范围 */
@property (nonatomic,strong) NSString * scope;

/** 公司地址 */
@property (nonatomic,strong) NSString * address;

/** 批准时间 */
@property (nonatomic,strong) NSString * approval_time;

/** 商业分配时间 */
@property (nonatomic,strong) NSString * busniss_alloted_time_later;

/** 商业分配时间 */
@property (nonatomic,strong) NSString * busniss_alloted_time_start;

/** 法人 */
@property (nonatomic,strong) NSString * corporation;

/** 日期 */
@property (nonatomic,strong) NSString * data_time;

/** 注册号 */
@property (nonatomic,strong) NSString * register_no;

/** 登记局 */
@property (nonatomic,strong) NSString * registdepartment;

/** 变更时间 */
@property (nonatomic,strong) NSString * revoke_time;

/** 股东信息 */
@property (nonatomic,strong) NSArray * stockholder;

/** 主要成员 */
@property (nonatomic,strong) NSArray * member;

/** 分支机构 */
@property (nonatomic,strong) NSArray * branch;

/** 变更记录 */
@property (nonatomic,strong) NSArray * modify;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

/** legal_person */
@property (nonatomic,strong) NSString * legal_person;

/** start_date */
@property (nonatomic,strong) NSString * start_date;

/** reg_capital */
@property (nonatomic,strong) NSString * reg_capital;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
