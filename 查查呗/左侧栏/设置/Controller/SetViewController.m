//
//  SetViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * _shareView;
    UILabel * _nameLabel;
    NSString * _string;
    NSString * _textFont;
    NSString * _uid;
    NSString * _request;
}

@property (weak, nonatomic) IBOutlet UITableView *setTableView;

@property (nonatomic,strong) NSArray * setInfoArray;

@end

@implementation SetViewController

- (NSArray *)setInfoArray
{
    if (_setInfoArray == nil) {
        
        self.setInfoArray = @[
                              @{@"image":[UIImage imageNamed:@"app13.png"],
                                @"text":@"分享"},
                              @{@"image":[UIImage imageNamed:@"app15.png"],
                                @"text":@"问题建议"},
                              @{@"image":[UIImage imageNamed:@"app14.png"],
                                @"text":@"用户协议"},
                              @{@"image":[UIImage imageNamed:@"app16.png"],
                                @"text":@"关于我们"},
                              ];

    }
    
    return _setInfoArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置导航栏
    [self setNavigationBar];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //添加内容视图   
    [self addContentView];
    
    leftButton;
     
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"设置");
}

//添加内容视图
-(void)addContentView
{
    self.view.backgroundColor = [UIColor whiteColor];

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-90, 18, 70, 30)];
    
    self.setTableView.backgroundColor = [UIColor clearColor];
    
    self.setTableView.scrollEnabled = NO;
    
    self.setTableView.tableFooterView = [[UIView alloc]init];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.setInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"cellIdentifier";
    
    SetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (!cell) {
        
        cell=[[SetViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell setContentView:self.setInfoArray[indexPath.row]];

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //显示最右边的箭头
    return cell;

}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.setTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
      
        NSURL *shareUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/cn/app/cha-cha-bei/id1111485201?mt=8"]];
        NSArray *activityItem=@[shareUrl];
        UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:activityItem applicationActivities:nil];
        
        //设置不出现的活动项目
        activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter
                                                     ,UIActivityTypeMessage
                                                     ,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,
                                                     UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,
                                                     UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks
                                                     ];
        
        [self.navigationController presentViewController:activityController animated:YES completion:nil];
    }
    if (indexPath.row==1) {
        
        AdviceViewController *adviceVC=[[AdviceViewController alloc]initWithNibName:@"AdviceViewController" bundle:nil];
        [self.navigationController pushViewController:adviceVC animated:YES];
    }
    if (indexPath.row==2) {
        
        AboutViewController *aboutVC=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if (indexPath.row==3) {
        
        WeViewController *weVC=[[WeViewController alloc]initWithNibName:@"WeViewController" bundle:nil];
        [self.navigationController pushViewController:weVC animated:YES];
    }
}

- (void)removeView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_shareView setFrame:CGRectMake(0, [UIUtils getWindowHeight], [UIUtils getWindowWidth], SHARE_CONTENT_HEIGHT)];
                     } completion:^(BOOL finished) {
                         [_shareView removeFromSuperview];
                     }];
}

@end
