//
//  NewViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 16/1/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class newModel;

@interface NewViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titkeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) newModel * newmodel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
