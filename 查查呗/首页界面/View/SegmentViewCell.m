//
//  SegmentViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SegmentViewCell.h"

@implementation SegmentViewCell

static NSString *cellID=@"TopButtonViewCell";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    SegmentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SegmentViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    return cell;
}

@end
