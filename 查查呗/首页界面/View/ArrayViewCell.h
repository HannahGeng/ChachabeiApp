//
//  ArrayViewCell.h
//  查查呗
//
//  Created by zdzx-008 on 15/12/22.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetail;
@class attentionModel;

@interface ArrayViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

//类别模型
@property (nonatomic,strong)CompanyDetail * company;

/** 关注模型 */
@property (nonatomic,strong)attentionModel * attention;

@end
