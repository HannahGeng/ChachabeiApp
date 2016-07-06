//
//  TableViewCell.h
//  FlipTableView
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *registrationLabel;
@property (weak, nonatomic) IBOutlet UILabel *SetupDate;
@property (weak, nonatomic) IBOutlet UILabel *registeredCapital;
@property (weak, nonatomic) IBOutlet UILabel *registrationID;
@property (weak, nonatomic) IBOutlet UILabel *companyType;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CompanyDetail * companyDetail;

@end
