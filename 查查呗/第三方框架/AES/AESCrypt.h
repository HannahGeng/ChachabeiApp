//
//  AESCrypt.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
// 
#import <Foundation/Foundation.h>

@interface AESCrypt : NSObject

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password;//加密
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;//解密
+ (NSString *)decrypt:(NSString *)base64EncodedString;//base64解密
//+ (NSString *)encrypt:(NSString *)message;//base64加密

@end
