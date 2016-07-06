//
//  ContentViewCell.m
//  chachabei
//
//  Created by zdzx-008 on 15/11/23.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ContentViewCell.h"

@interface ContentViewCell ()
{
    UIImageView *_pointImage;
    UILabel *_titleLabel;
    UIImageView *_iamgeView;
}
@end

@implementation ContentViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加内容视图
        [self addContentView];
    }
    return self;
    
}
//添加内容视图
-(void)addContentView{
    
    _pointImage =[[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    [self addSubview:_pointImage];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointImage.frame)+15, 5, [UIUtils getWindowWidth]-CGRectGetMaxX(_pointImage.frame)-50-10, 40)];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    [self addSubview:_titleLabel];
    
    _iamgeView=[[UIImageView alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-70, 20, 7, 13)];
    _iamgeView.image=[UIImage imageNamed:@"jiantou.png"];
    [self addSubview:_iamgeView];
    
}
-(void)setContentView:(NSDictionary *)dictionary{
    
    _pointImage.image=dictionary[@"image"];
    _titleLabel.text=dictionary[@"text"];
}

@end
