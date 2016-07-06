//
//  changeModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/27.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changeModel : NSObject

/** 法定代表人变更 */
@property (nonatomic,strong) NSString * change_item;

/** 变更后 */
@property (nonatomic,strong) NSString * after_change;

/** 变更时间 */
@property (nonatomic,strong) NSString * change_date;

/** 变更类型 */
@property (nonatomic,strong) NSString * changecompany_type;

/** 变更前 */
@property (nonatomic,strong) NSString * before_change;

/** 注册号 */
@property (nonatomic,strong) NSString * regist_no;

/** 高度 */
@property (nonatomic,assign) CGFloat cellHeight;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
