//
//  RegistViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface RegistViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *businessRange;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CompanyDetail * companyDetail;

@end
