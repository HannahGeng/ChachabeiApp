//
//  DatabaseManager.h
//  什么值得买
//
//  Created by iJeff on 16/1/12.
//  Copyright (c) 2016年 iJeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

//单例
+(DatabaseManager *)sharedManger;

//插入数据
-(BOOL)insertCompanys:(NSString *)companyName cityName:(NSString *)cityName;

//获取数据
-(NSArray *)getAllCompanys;

//删除数据
- (void)removeAllCompanys;

@end
