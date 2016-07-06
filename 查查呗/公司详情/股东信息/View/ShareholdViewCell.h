//
//  ShareholdViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class shareholdModel;

@interface ShareholdViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (nonatomic,strong)shareholdModel * sharehold;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
