//
//  TopButtonVC.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopButtonVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *introduceButton;
@property (weak, nonatomic) IBOutlet UIButton *creditButton;
@property (weak, nonatomic) IBOutlet UIButton *authorizationButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
