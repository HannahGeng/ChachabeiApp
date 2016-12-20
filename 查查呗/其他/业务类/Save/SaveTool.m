//
//  SaveTool.m
//  查查呗
//
//  Created by zdzx-008 on 2016/10/19.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "SaveTool.h"

@implementation SaveTool

+ (id)objectForKey:(NSString *)defaultName{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
}

@end
