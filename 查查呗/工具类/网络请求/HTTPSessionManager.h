//
//  HTTPSessionManager.h
//  什么值得买
//
//  Created by iJeff on 16/1/12.
//  Copyright (c) 2016年 iJeff. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求网络数据的返回结果Block
typedef void(^ResultBlock)(id responseObject, NSError *error);

@interface HTTPSessionManager : NSObject

//单例
+ (HTTPSessionManager *)sharedManager;

//GET
- (void)GET:(NSString *)url parameters:(id)parameters result:(ResultBlock)result;

- (void)POST:(NSString *)url parameters:(id)parameters result:(ResultBlock)result;
@end
