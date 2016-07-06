//
//  MessageViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 16/1/13.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
