//
//  UIButton+ChangeFont.m
//  查查呗
//
//  Created by binghan geng on 2017/1/21.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "UIButton+ChangeFont.h"

@implementation UIButton (ChangeFont)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        
        NSString * str = APP_Font;
        self.titleLabel.font = [UIFont systemFontOfSize:15 * [str floatValue]];
    }
    return self;
}

@end
