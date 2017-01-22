//
//  RegistViewCell4.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "RegistViewCell4.h"

@implementation RegistViewCell4

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.registdepartment isEqualToString:@"null"]) {
        
        self.registAuthority.text = @"-";
        
    }else{
        
         self.registAuthority.text = companyDetail.registdepartment;
    }
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"RegistViewCell4";
    RegistViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegistViewCell4" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        //        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
