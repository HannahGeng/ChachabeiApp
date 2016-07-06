//
//  BranchViewCell.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/6.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "BranchViewCell.h"

@implementation BranchViewCell
- (void)setBranch:(BranchModel *)branch
{
    _branch = branch;
    
    if ([branch.company_name isEqual:@"null"]) {
        
        self.companyName.text = @"---";
        
    }else{
        
        self.companyName.text = branch.company_name;

    }
    
    if ([branch.regist_no isEqual:@"null"]) {
        
        self.LegalPerson.text = @"---";
        
    }else{
        
        self.LegalPerson.text = branch.regist_no;
    }
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"BranchViewCell";
    BranchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BranchViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        //        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    }
    return cell;
}

@end
