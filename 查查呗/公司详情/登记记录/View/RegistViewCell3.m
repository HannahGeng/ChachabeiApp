//
//  RegistViewCell3.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "RegistViewCell3.h"

@implementation RegistViewCell3

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    if ([companyDetail.establish_data isEqualToString:@"null"]) {
    
        self.issueDate.text = @"-";
        
    }else{
    
        self.issueDate.text = companyDetail.establish_data;
    }
    
    if ([companyDetail.busniss_alloted_time_start isEqualToString:@"null"] || [companyDetail.busniss_alloted_time_later isEqualToString:@"null"]) {
        
        self.businessTerm.text = [NSString stringWithFormat:@"-"];
    }else{
        
        self.businessTerm.text = companyDetail.term;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"RegistViewCell3";
    RegistViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegistViewCell3" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
//        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}
@end
