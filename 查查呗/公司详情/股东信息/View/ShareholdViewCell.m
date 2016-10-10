//
//  ShareholdViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ShareholdViewCell.h"

@interface ShareholdViewCell ()

@end

@implementation ShareholdViewCell

static NSString *cellID=@"Sharehold";

- (void)setSharehold:(shareholdModel *)sharehold
{
    _sharehold = sharehold;
    self.positionLabel.text = sharehold.shareholder_type;
    self.companyName.text = sharehold.shareholder_name;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    ShareholdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShareholdViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
