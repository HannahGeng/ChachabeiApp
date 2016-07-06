//
//  SearchViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
