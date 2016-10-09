//
//  ButtonViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ButtonViewCell.h"

@implementation ButtonViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TopButtonViewCell";
    ButtonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ButtonViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell addSubview:cell.redianButton];
    [cell addSubview:cell.nearButton];
    [cell addSubview:cell.serviceButton];

    return cell;
}

- (void)setRedianButton:(UIButton *)redianButton
{
    _redianButton = redianButton;
    
    [_redianButton buttonWithImage:[UIImage imageNamed:@"app17.png"] imageEdgeInsets:UIEdgeInsetsMake(-5,25,20,self.redianButton.titleLabel.bounds.size.width) title:@"热点" titleEggeInsets:UIEdgeInsetsMake(35, -self.redianButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:14];
}

- (void)setNearButton:(UIButton *)nearButton
{
    _nearButton = nearButton;
    
    [_nearButton buttonWithImage:[UIImage imageNamed:@"app18.png"] imageEdgeInsets:UIEdgeInsetsMake(-5,25,20,self.nearButton.titleLabel.bounds.size.width) title:@"附近" titleEggeInsets:UIEdgeInsetsMake(35, -self.nearButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:14];
}

- (void)setServiceButton:(UIButton *)serviceButton
{
    _serviceButton = serviceButton;
    
    [_serviceButton buttonWithImage:[UIImage imageNamed:@"app19.png"] imageEdgeInsets:UIEdgeInsetsMake(-5,25,20,self.serviceButton.titleLabel.bounds.size.width) title:@"客服" titleEggeInsets:UIEdgeInsetsMake(35, -self.serviceButton.titleLabel.bounds.size.width-25, 0, 0) titleFont:14];
}

@end
