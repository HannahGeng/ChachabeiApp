//
//  UnderButtonVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import "UnderButtonVC.h"

@implementation UnderButtonVC

static NSString *cellID=@"TopButtonViewCell";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    UnderButtonVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UnderButtonVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.investorsButton buttonWithImage:[UIImage imageNamed:@"app499.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.investorsButton.titleLabel.bounds.size.width-7) title:@"投资人" titleEggeInsets:UIEdgeInsetsMake(45, -cell.investorsButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.investorsButton];
    
    [cell.reportButton buttonWithImage:[UIImage imageNamed:@"app50.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.reportButton.titleLabel.bounds.size.width-7) title:@"企业年报" titleEggeInsets:UIEdgeInsetsMake(45, -cell.reportButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.reportButton];
    
    [cell.mapButton buttonWithImage:[UIImage imageNamed:@"app51.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.mapButton.titleLabel.bounds.size.width-7) title:@"企业图谱" titleEggeInsets:UIEdgeInsetsMake(45, -cell.mapButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.mapButton];
    
    [cell.investmentButton buttonWithImage:[UIImage imageNamed:@"app52.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.investmentButton.titleLabel.bounds.size.width-7) title:@"对外投资" titleEggeInsets:UIEdgeInsetsMake(45, -cell.investmentButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.investmentButton];
    
    return cell;
}

@end
