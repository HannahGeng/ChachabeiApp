//
//  HotNewsViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 2017/1/12.
//  Copyright © 2017年 zdzx. All rights reserved.
//

#import "HotNewsViewCell.h"

@interface HotNewsViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HotNewsViewCell

- (void)setHotNews:(HotNewsModel *)hotNews
{
    _hotNews = hotNews;
    
    self.titleLabel.text = hotNews.title;
    self.timeLabel.text = hotNews.date;
//    [self.headView sd_setImageWithURL:[NSURL URLWithString:hotNews.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
