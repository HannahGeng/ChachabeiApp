//
//  attentionModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface attentionModel : NSObject

/** 关注企业的名称 */
@property (nonatomic,strong) NSString * cname;

/** 省份名称 */
@property (nonatomic,strong) NSString * province_name;

@property (nonatomic,assign) BOOL isSelect;

@end
