//
//  aboutViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class aboutModel;

@interface aboutViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 模型 */
@property (nonatomic,strong) aboutModel * about;

@end
