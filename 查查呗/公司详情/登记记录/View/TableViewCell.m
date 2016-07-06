//
//  TableViewCell.m
//  FlipTableView
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.corporation isEqualToString:@"null"]) {
        self.nameLabel.text = @"---";
    }else{
        self.nameLabel.text = companyDetail.corporation;
    }
    
    if ([companyDetail.establish_data isEqualToString:@"null"]) {
        self.SetupDate.text = @"---";
    }else{
        self.SetupDate.text = companyDetail.establish_data;
    }
    self.registrationLabel.text = @"登记成立";
    
    if ([companyDetail.capital isEqualToString:@"null"]) {
        self.registeredCapital.text = @"---";
    }else{
        self.registeredCapital.text = companyDetail.capital;
    }
    
    if ([companyDetail.regist_no isEqualToString:@"null"]) {
        self.registrationID.text = @"---";
    }else{
        self.registrationID.text = companyDetail.regist_no;
    }
    
    if ([companyDetail.company_type isEqualToString:@"null"]) {
        self.companyType.text = @"---";
    }else{
        self.companyType.text = companyDetail.company_type;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
//        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
