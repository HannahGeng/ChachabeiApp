//
//  ResultsViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ResultsViewCell.h"

@implementation ResultsViewCell

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.company_name isEqualToString:@"null"]) {
        self.company_name.text = @"---";
    }else{
        self.company_name.text = companyDetail.company_name;
    }
    
    if ([companyDetail.capital isEqualToString:@"null"]) {
        self.capital.text = @"---";
    }else{
        self.capital.text = companyDetail.reg_capital;
    }

    if ([companyDetail.establish_data isEqualToString:@"unll"]) {
        self.establishment_date.text = @"---";
    }else{
        self.establishment_date.text = companyDetail.start_date;
    }
    
    if ([companyDetail.legal_person isEqualToString:@"null"]) {
        self.corporation.text = @"---";
    }else{
        self.corporation.text = companyDetail.legal_person;
    }
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"result";
    ResultsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultsViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
//        cell.backgroundColor=[UIColor greenColor];
    }
    return cell;
}

@end
