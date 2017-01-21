//
//  UILabel+LabelFontChange.m
//  更改字体大小Demo
//
//  Created by zdzx-008 on 16/9/7.
//  Copyright © 2016年 zdzx-008. All rights reserved.
//

#import "UILabel+LabelFontChange.h"

@implementation UILabel (LabelFontChange)

+(UIFont *)changeFont
{
    NSString * str = APP_Font;
    
    return [UIFont systemFontOfSize:15 * [str floatValue]];
}

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    NSString * str = APP_Font;
    
    [self myInitWithCoder:aDecode];
    if (self) {

        self.font = [UIFont systemFontOfSize:15 * [str floatValue]];
    }
    return self;
}

@end
