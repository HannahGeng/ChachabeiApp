//
//  ResultsViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/12/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface ResultsViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *company_name;
@property (weak, nonatomic) IBOutlet UILabel *corporation;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *establishment_date;

@property (nonatomic,strong) CompanyDetail * companyDetail;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
