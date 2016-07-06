//
//  ChangeViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 16/1/6.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class changeModel;

@interface ChangeViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *change_item;
@property (weak, nonatomic) IBOutlet UILabel *before_change;
@property (weak, nonatomic) IBOutlet UILabel *after_change;

/** changeModel */
@property (nonatomic,strong) changeModel * changemodel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
