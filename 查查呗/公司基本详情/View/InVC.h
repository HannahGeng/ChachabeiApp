//
//  InVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *trademarkButton;
@property (weak, nonatomic) IBOutlet UIButton *promisesButton;
@property (weak, nonatomic) IBOutlet UIButton *recruitmentButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
