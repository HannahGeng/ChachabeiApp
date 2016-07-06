//
//  AttentionViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "AttentionViewCell.h"

@interface AttentionViewCell ()
{
    UILabel *_titleLabel;
}
@end

@implementation AttentionViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        //添加内容视图
        [self addContentView];
    }
    return self;
    
}
//添加内容视图
-(void)addContentView{
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 7, 300, 50)];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    [self addSubview:_titleLabel];
}
-(void)setContentView:(NSDictionary *)dictionary{
    
    _titleLabel.text=dictionary[@"text"];
}

@end
