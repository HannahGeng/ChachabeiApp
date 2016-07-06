//
//  SearVC.h
//  查查呗
//
//  Created by zdzx-008 on 16/5/3.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class attentionModel;

@interface SearVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *attentionCompanyLabel;
/** 模型 */
@property (nonatomic,strong) attentionModel * attention;

@end
