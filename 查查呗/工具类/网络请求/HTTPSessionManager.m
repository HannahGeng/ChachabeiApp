//
//  HTTPSessionManager.m
//  什么值得买
//
//  Created by iJeff on 16/1/12.
//  Copyright (c) 2016年 iJeff. All rights reserved.
//

#import "HTTPSessionManager.h"

@implementation HTTPSessionManager
{
    AFHTTPSessionManager *manager;
}

//单例
+ (HTTPSessionManager *)sharedManager
{
    static HTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPSessionManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        manager = [AFHTTPSessionManager manager];
    }
    return self;
}

//GET
- (void)GET:(NSString *)url parameters:(id)parameters result:(ResultBlock)result
{
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //回传数据
        if (result) {
            result(responseObject, nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
        //回传错误
        if (result) {
            result(nil, error);
        }
        
    }];
    
}


//POST
- (void)POST:(NSString *)url parameters:(id)parameters result:(ResultBlock)result
{
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //回传数据
        if (result) {
            result(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
        //回传错误
        if (result) {
            result(nil, error);
        }
        
    }];
    

}

@end
