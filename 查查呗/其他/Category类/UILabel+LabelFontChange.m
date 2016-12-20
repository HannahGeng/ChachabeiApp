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
        
    return [UIFont systemFontOfSize:17 * [str floatValue]];
}

@end
