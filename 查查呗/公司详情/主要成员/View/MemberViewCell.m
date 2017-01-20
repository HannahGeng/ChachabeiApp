//
//  MemberViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "MemberViewCell.h"

@implementation MemberViewCell

- (void)setMember:(memberModel *)member
{
     _member = member;

    if (((long)member.sequence + 1) % 2 == 0) {//偶数
        
                //偶数
        self.name.text = member.surname;
        self.position.text = member.position;

    }else{
        
        //奇数
        self.nameLabel.text = member.surname;
        self.positionLabel.text = member.position;
    }
    
    //强制布局
    [self layoutIfNeeded];
    
    //   计算cell的高度
    CGFloat leftMaxY = CGRectGetMaxY(self.position.frame);
    CGFloat rightMaxY = CGRectGetMaxY(self.positionLabel.frame);
    member.cellHeight = MAX(leftMaxY, rightMaxY);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString * cellID = @"member";
    
    MemberViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MemberViewCell" owner:self options:nil] lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

@end
