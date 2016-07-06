//
//  ButtonViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *redianButton;
@property (weak, nonatomic) IBOutlet UIButton *nearButton;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
