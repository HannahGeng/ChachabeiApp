//
//  TableVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "TableVC.h"

@implementation TableVC

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.corporation isEqualToString:@"null"]) {
        self.comporsation.text = @"---";
        
    }else{
        self.comporsation.text = companyDetail.legal_person;
    }
    
    if ([companyDetail.capital isEqualToString:@"null"]) {
        self.fund.text = @"---";
        
    }else{
        self.fund.text = companyDetail.capital;
    }
    
    if ([companyDetail.establish_data isEqualToString:@"null"]) {
        self.estimatedTime.text = @"---";
    }else{
        self.estimatedTime.text = companyDetail.start_date;
    }
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TopButtonViewCell";
    TableVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
