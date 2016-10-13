//
//  SearVC.m
//  查查呗
//
//  Created by zdzx-008 on 16/5/3.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "SearVC.h"

@interface SearVC ()

@end

@implementation SearVC

- (void)setAttention:(attentionModel *)attention
{
    _attention = attention;
    
    if (attention.cname == nil) {
        
        self.attentionCompanyLabel.text = @"---";
        
    }else{
        self.attentionCompanyLabel.text = attention.cname;
    }
}

@end
