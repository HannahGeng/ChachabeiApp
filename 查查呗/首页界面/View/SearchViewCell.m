//
//  SearchViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
    
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"SearchViewCell";
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2.png"]];
    }
    return cell;
}

- (IBAction)leftClick {
    
    AppShare;
    [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
