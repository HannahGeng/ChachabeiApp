//
//  HeardViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface HeardViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *registLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xiXiImageView;

/**
 *  企业模型
 */
@property (nonatomic,strong) CompanyDetail * companyDetail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
