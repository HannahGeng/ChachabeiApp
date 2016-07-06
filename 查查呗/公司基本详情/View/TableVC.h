//
//  TableVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;

@interface TableVC : UITableViewCell

/**
 *  企业法人
 */
@property (weak, nonatomic) IBOutlet UILabel *comporsation;

/**
 *  注册资金
 */
@property (weak, nonatomic) IBOutlet UILabel *fund;

/**
 *  成立日期
 */
@property (weak, nonatomic) IBOutlet UILabel *estimatedTime;

/**
 *  企业模型
 */
@property (nonatomic,strong) CompanyDetail * companyDetail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
