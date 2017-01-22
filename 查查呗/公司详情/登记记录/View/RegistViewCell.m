//
//  RegistViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "RegistViewCell.h"

@implementation RegistViewCell

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    if ([companyDetail.scope isEqualToString:@"null"]) {
        self.businessRange.text = @"-";
    }else{
        self.businessRange.text = companyDetail.scope;
         self.businessRange.font = [UIFont systemFontOfSize:15];
    }
    
    //强制布局
    [self layoutIfNeeded];
    companyDetail.cellHeight = CGRectGetMaxY(self.businessRange.frame);

}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"RegistViewCell";
    RegistViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegistViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return cell;
}


@end
