//
//  AddressVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import "AddressVC.h"

@implementation AddressVC

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.address isEqualToString:@"null"]) {
        self.addressTextView.text = @"-";
    }else{
        self.addressTextView.text = companyDetail.address;
    }
    self.addressTextView.font = [UIFont systemFontOfSize:14];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TopButtonViewCell";
    AddressVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        //        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
