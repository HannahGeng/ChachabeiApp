//
//  ArrayViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/22.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ArrayViewCell.h"

@interface ArrayViewCell ()

@end

@implementation ArrayViewCell

- (void)setCompany:(CompanyDetail *)company
{
    _company = company;
    
    self.companyLabel.text = company.company_name;
}

- (void)setAttention:(attentionModel *)attention
{
    _attention = attention;
    
    self.companyLabel.text = attention.cname;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ArrayViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"company"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
