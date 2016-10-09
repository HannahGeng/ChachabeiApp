//
//  TopButtonViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "TopButtonViewCell.h"

@interface TopButtonViewCell()

@end

@implementation TopButtonViewCell

static NSString *cellID=@"TopButtonViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    TopButtonViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopButtonViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell addSubview:cell.codeButton];
    [cell addSubview:cell.cardButton];
    [cell addSubview:cell.recordButton];

    return cell;
}

//扫二维码
- (void)setCodeButton:(UIButton *)codeButton
{
    _codeButton = codeButton;
    
    [_codeButton buttonWithImage:[UIImage imageNamed:@"app21"] imageEdgeInsets:UIEdgeInsetsMake(-5,28,25,self.codeButton.titleLabel.bounds.size.width-20) title:@"扫二维码" titleEggeInsets:UIEdgeInsetsMake(65, -self.codeButton.titleLabel.bounds.size.width-65, 0, 0) titleFont:14];
}

//扫名片
- (void)setCardButton:(UIButton *)cardButton
{
    _cardButton = cardButton;
    
    [_cardButton buttonWithImage:[UIImage imageNamed:@"app22"] imageEdgeInsets:UIEdgeInsetsMake(-5,25,25,self.cardButton.titleLabel.bounds.size.width-15) title:@"扫名片" titleEggeInsets:UIEdgeInsetsMake(65, -self.cardButton.titleLabel.bounds.size.width-60, 0, 0) titleFont:14];
}

//失信纪录
- (void)setRecordButton:(UIButton *)recordButton
{
    _recordButton = recordButton;
    
    [_recordButton buttonWithImage:[UIImage imageNamed:@"app23"] imageEdgeInsets:UIEdgeInsetsMake(-5,32,25,self.recordButton.titleLabel.bounds.size.width-25) title:@"失信记录" titleEggeInsets:UIEdgeInsetsMake(65, -self.recordButton.titleLabel.bounds.size.width-55, 0, 0) titleFont:14];
}

@end
