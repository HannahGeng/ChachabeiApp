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
        self.comporsation.text = companyDetail.corporation;
    }
    
    if ([companyDetail.capital isEqualToString:@"null"]) {
        self.fund.text = @"---";
    }else{
        self.fund.text = companyDetail.capital;
    }
    
    if ([companyDetail.establish_data isEqualToString:@"null"]) {
        self.estimatedTime.text = @"---";
    }else{
        self.estimatedTime.text = companyDetail.establish_data;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TopButtonViewCell";
    TableVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
//        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
