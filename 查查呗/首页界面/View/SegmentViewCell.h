//
//  SegmentViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *CompanyButton;
@property (weak, nonatomic) IBOutlet UIButton *FocusButton;
@property (weak, nonatomic) IBOutlet UIImageView *LineIamgeView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
