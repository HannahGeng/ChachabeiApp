//
//  AddressVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface AddressVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (nonatomic,strong) CompanyDetail * companyDetail;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
