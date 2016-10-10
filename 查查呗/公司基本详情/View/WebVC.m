//
//  WebVC.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/27.
//  Copyright (c) 2015年 zdzx. All rights reserved.
//

#import "WebVC.h"

@implementation WebVC

static NSString *cellID=@"TopButtonViewCell";

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    WebVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WebVC" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    return cell;
}


@end
