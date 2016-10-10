//
//  InVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "InVC.h"

@implementation InVC

static NSString *cellID=@"TopButtonViewCell";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    InVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell.cardButton buttonWithImage:[UIImage imageNamed:@"app455.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.cardButton.titleLabel.bounds.size.width-7) title:@"企业二维码" titleEggeInsets:UIEdgeInsetsMake(45, -cell.cardButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.cardButton];
    
    [cell.trademarkButton buttonWithImage:[UIImage imageNamed:@"app466.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.trademarkButton.titleLabel.bounds.size.width-7) title:@"商标展示" titleEggeInsets:UIEdgeInsetsMake(45, -cell.trademarkButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.trademarkButton];
    
    [cell.promisesButton buttonWithImage:[UIImage imageNamed:@"app47.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.promisesButton.titleLabel.bounds.size.width-7) title:@"失信记录" titleEggeInsets:UIEdgeInsetsMake(45, -cell.promisesButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.promisesButton];
    
    [cell.recruitmentButton buttonWithImage:[UIImage imageNamed:@"app488.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.recruitmentButton.titleLabel.bounds.size.width-7) title:@"招聘信息" titleEggeInsets:UIEdgeInsetsMake(45, -cell.recruitmentButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.recruitmentButton];

    return cell;
}

@end
