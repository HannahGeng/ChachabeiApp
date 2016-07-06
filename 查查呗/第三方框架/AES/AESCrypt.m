//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh

#import "AESCrypt.h"

#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

@implementation AESCrypt
//加密
+ (NSString *)encrypt:(NSString *)message password:(NSString *)password
{
  NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
  NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
  return base64EncodedString;
}
//解密
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password
{
  NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
  NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
  return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}
//+ (NSString *)encrypt:(NSString *)message
//{
//    NSDate *encryptedData=[[message dataUsingEncoding:NSUTF8StringEncoding] error:nil];
//    NSString *base64String = [NSString base64StringFromData:encryptedData];
//
//    return base64String;
//}
//base64解密
+ (NSString *)decrypt:(NSString *)base64EncodedString
{
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSString *aString = [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    return aString;
}
@end
