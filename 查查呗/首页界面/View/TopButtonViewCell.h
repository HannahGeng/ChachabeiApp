//
//  TopButtonViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopButtonViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
