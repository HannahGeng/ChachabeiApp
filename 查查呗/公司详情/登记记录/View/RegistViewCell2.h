//
//  RegistViewCell2.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface RegistViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,strong)CompanyDetail * companyDetail;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
