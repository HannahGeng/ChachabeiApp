//
//  TopButtonVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "TopButtonVC.h"

@implementation TopButtonVC

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"TopButtonViewCell";
    TopButtonVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopButtonVC" owner:self options:nil] lastObject];
        
    }
    
    [cell.messageButton buttonWithImage:[UIImage imageNamed:@"app41.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.messageButton.titleLabel.bounds.size.width-7) title:@"工商信息" titleEggeInsets:UIEdgeInsetsMake(45, -cell.messageButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.messageButton];

    [cell.introduceButton buttonWithImage:[UIImage imageNamed:@"app422.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.introduceButton.titleLabel.bounds.size.width-7) title:@"公司介绍" titleEggeInsets:UIEdgeInsetsMake(45, -cell.introduceButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.introduceButton];
    
    [cell.creditButton buttonWithImage:[UIImage imageNamed:@"app433.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.creditButton.titleLabel.bounds.size.width-7) title:@"信用评级" titleEggeInsets:UIEdgeInsetsMake(45, -cell.creditButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.creditButton];
    
    [cell.authorizationButton buttonWithImage:[UIImage imageNamed:@"app444.png"] imageEdgeInsets:UIEdgeInsetsMake(5,28,30,cell.authorizationButton.titleLabel.bounds.size.width-7) title:@"授权记录" titleEggeInsets:UIEdgeInsetsMake(45, -cell.authorizationButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:15];
    [cell addSubview:cell.authorizationButton];
    
    return cell;
}


@end
