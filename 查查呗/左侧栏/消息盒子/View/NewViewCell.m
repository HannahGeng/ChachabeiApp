//
//  NewViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/15.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "NewViewCell.h"

@implementation NewViewCell
- (void)setNewmodel:(newModel *)newmodel
{
    _newmodel = newmodel;
    self.timeLabel.text = newmodel.title;
    self.contentLabel.text = newmodel.content;
    self.timeLabel.text = newmodel.msgtime;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"NewViewCell";
    NewViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
//        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
