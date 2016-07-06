//
//  PersonalViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/4.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "PersonalViewCell.h"

@implementation PersonalViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PersonalViewCell";
    PersonalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonalViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
