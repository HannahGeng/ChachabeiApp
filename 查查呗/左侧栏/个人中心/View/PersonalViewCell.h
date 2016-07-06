//
//  PersonalViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/12/4.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
