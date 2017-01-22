//
//  WebVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@property (weak, nonatomic) IBOutlet UILabel *webLabel;

@end

@implementation WebVC

static NSString *cellID=@"TopButtonViewCell";

- (void)setCompanyDetail:(CompanyDetail *)companyDetail
{
    _companyDetail = companyDetail;
    
    AppShare;
    
    if ([companyDetail.website isEqualToString:@"null"]) {
        self.webLabel.text = @"-";
    }else{
        self.webLabel.text = companyDetail.website;
        
        app.urlStr = self.webLabel.text;
    }
    self.webLabel.font = [UIFont systemFontOfSize:14];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    WebVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WebVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    
    return cell;
}


@end
