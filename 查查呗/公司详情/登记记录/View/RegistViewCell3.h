//
//  RegistViewCell3.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface RegistViewCell3 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *issueDate;
@property (weak, nonatomic) IBOutlet UILabel *businessTerm;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) CompanyDetail * companyDetail;

@end
