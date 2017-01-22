//
//  SetViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SetViewCell.h"

@interface SetViewCell ()
{
    NSString * _string;
}
@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UIImageView * pointImage;

@end

@implementation SetViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //添加内容视图
        [self addContentView];
    }
    
    return self;
}

//添加内容视图
-(void)addContentView{
    
    self.pointImage =[[UIImageView alloc] initWithFrame:CGRectMake(20, 17, 30, 30)];
    [self addSubview:_pointImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointImage.frame)+15, 7, [UIUtils getWindowWidth]-CGRectGetMaxX(_pointImage.frame)-50-10, 50)];
    
    _string = APP_Font;
    
    self.titleLabel.font = [UIFont systemFontOfSize:17 * [_string integerValue]];
        
    [self addSubview:_titleLabel];
}

-(void)setContentView:(NSDictionary *)dictionary{
    
    self.pointImage.image=dictionary[@"image"];
    self.titleLabel.text=dictionary[@"text"];
}

@end
