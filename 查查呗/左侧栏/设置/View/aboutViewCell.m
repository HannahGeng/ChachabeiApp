//
//  aboutViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 16/5/1.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "aboutViewCell.h"

@interface aboutViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation aboutViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"about";
    aboutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;

}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置label每一行文字的最大宽度
    // 为了保证计算出来的数值 跟 真正显示出来的效果 一致
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
}

- (void)setAbout:(aboutModel *)about
{
    _about = about;
    self.contentLabel.text = [about.content stringByReplacingOccurrencesOfString:@"#" withString:@"\n"];
    
       // 强制布局
    [self layoutIfNeeded];
    
    about.cellHeight = CGRectGetMaxY(self.contentLabel.frame);
}


@end
