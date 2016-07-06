//
//  HeardViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "HeardViewCell.h"

@implementation HeardViewCell

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.company_name isEqualToString:@"null"]) {
        self.companyName.text = @"---";
    }else{
        self.companyName.text = companyDetail.company_name;
    }
    
    if ([companyDetail.regist_no isEqualToString:@"null"]) {
        self.IDLabel.text = @"---";
    }else{
        self.IDLabel.text = companyDetail.regist_no;
    }
    
    if ([companyDetail.company_type isEqualToString:@"null"]) {
        self.label.text = @"---";
    }else{
        self.label.text = companyDetail.company_type;
    }

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor=LIGHT_BACKGROUND_COLOR;
        self.registLabel.textColor=LIGHT_BLUE_COLOR;
        self.IDLabel.textColor=LIGHT_BLUE_COLOR;
        self.label.textColor=LIGHT_BLUE_COLOR;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableVie
{
    static NSString * cellID = @"header";
    HeardViewCell * cell = [tableVie dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HeardViewCell" owner:self options:nil] lastObject];
        cell.selected = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
