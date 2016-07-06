//
//  TopButtonVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "TopButtonVC.h"

@implementation TopButtonVC
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"TopButtonViewCell";
    TopButtonVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopButtonVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        //        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}


@end
