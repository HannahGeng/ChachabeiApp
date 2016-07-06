//
//  MemberViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "MemberViewCell.h"

@implementation MemberViewCell

- (void)setMember:(memberModel *)member
{
    _member = member;

    if ([member.sequence intValue] %2 == 0) {//偶数
        
        //偶数
        self.name.text = member.surname;
        self.position.text = member.position;

    }else{
    
        //奇数
        self.nameLabel.text = member.surname;
        self.positionLabel.text = member.position;

    }
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"member";
    MemberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MemberViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    return cell;
}


@end
