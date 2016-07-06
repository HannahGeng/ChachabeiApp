//
//  UnderButtonVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnderButtonVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *investorsButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *investmentButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
