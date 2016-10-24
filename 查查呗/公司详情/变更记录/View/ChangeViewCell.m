//
//  ChangeViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/6.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "ChangeViewCell.h"

@implementation ChangeViewCell

- (void)setChangemodel:(changeModel *)changemodel
{
    _changemodel = changemodel;
    self.change_item.text = changemodel.change_item;
    self.before_change.text = changemodel.before_change;
    self.after_change.text = changemodel.after_change;
    
    //强制布局
    [self layoutIfNeeded];

    //计算cell的高度
    CGFloat leftMaxY = CGRectGetMaxY(self.before_change.frame) + 10;
    CGFloat rightMaxY = CGRectGetMaxY(self.after_change.frame) + 10;
    changemodel.cellHeight = MAX(leftMaxY, rightMaxY);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"change";
    ChangeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChangeViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

@end
