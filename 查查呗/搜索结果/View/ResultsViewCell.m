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
        self.capital.text = companyDetail.capital;
    }
    
//    if ([companyDetail.establish_data isEqualToString:@"unll"]) {
        self.establishment_date.text = @"---";
//    }else{
//        self.establishment_date.text = companyDetail.establish_data;
//    }
    
    if ([companyDetail.corporation isEqualToString:@"null"]) {
        self.corporation.text = @"---";
    }else{
        self.corporation.text = companyDetail.corporation;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
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
