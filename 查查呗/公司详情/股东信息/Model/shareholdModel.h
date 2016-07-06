//
//  shareholdModel.h
//  查查呗
//
//  Created by zdzx-008 on 16/4/23.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shareholdModel : NSObject

@property (nonatomic,strong) NSString * shareholder_name;
@property (nonatomic,strong) NSString * shareholder_type;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
