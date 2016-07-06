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

@end
