//
//  BranchViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 16/1/6.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BranchModel;

@interface BranchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *LegalPerson;
@property (nonatomic,weak) BranchModel * branch;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
