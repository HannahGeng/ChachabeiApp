//
//  MoreViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/22.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "MoreViewCell.h"

@interface MoreViewCell ()

@end

@implementation MoreViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
 //       self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"MoreViewCell";
    MoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
