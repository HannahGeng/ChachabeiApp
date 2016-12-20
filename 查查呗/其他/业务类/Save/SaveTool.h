//
//  SaveTool.h
//  查查呗
//
//  Created by zdzx-008 on 2016/10/19.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTool : NSObject

+ (id)objectForKey:(NSString *)defaultName;

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

@end
