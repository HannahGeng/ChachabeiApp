//
//  CCBLeftViewCell.m
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/15.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import "CCBLeftViewCell.h"

@interface CCBLeftViewCell ()

@end

@implementation CCBLeftViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString * ID = @"cell";

    CCBLeftViewCell * cell = [[CCBLeftViewCell alloc] init];
    
    if (cell == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
