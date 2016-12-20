//
//  CCBWelcomViewCell.m
//  CCB-Demo
//
//  Created by zdzx-008 on 2016/12/14.
//  Copyright © 2016年 Binngirl. All rights reserved.
//

#import "CCBWelcomViewCell.h"

@interface CCBWelcomViewCell ()

@property (nonatomic,weak) UIImageView * imageView;

@end

@implementation CCBWelcomViewCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

@end
