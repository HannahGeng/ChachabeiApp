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
    NSArray *_setInfoArray;
    
    UIView *_shareView;
//    UIView *_contentView;
    UIButton *_minButton;
    UIButton *_maxButton;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    
    NSString *_string;
    NSString *_maxStr;
    
    NSString *_textFont;
    
    NSString * _uid;
    NSString * _request;
}

@property (weak, nonatomic) IBOutlet UITableView *setTableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    leftButton;
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
    
    //加载数据
    [self loadData];
    
    //标准
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(standard) name:@"standard" object:nil];
    
    //变大
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bigger) name:@"bigger" object:nil];
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"设置");
}

//添加内容视图
-(void)addContentView
{
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-90, 18, 70, 30)];
    
    self.setTableView.backgroundColor=[UIColor clearColor];
    
    self.setTableView.scrollEnabled =NO;
    
    self.setTableView.tableFooterView=[[UIView alloc]init];
}

//加载数据
-(void)loadData
{
    _setInfoArray = @[
                      @{@"image":[UIImage imageNamed:@"app12.png"],
                        @"text":@"字体大小"},
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

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _setInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"cellIdentifier";
    
    SetViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *string=APP_Font;

    cell.textLabel.font = [UIFont systemFontOfSize:17 * [string floatValue]];
    
    if (!cell) {
        cell=[[SetViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setContentView:_setInfoArray[indexPath.row]];

    if (indexPath.row==0) {
        
        if ([_textFont isEqualToString:@"b"]) {
            _nameLabel.text=@"标准";
            
        }else{
            if ([_textFont isEqualToString:@"d"]) {
                _nameLabel.text=@"大号";
            }else{
                _nameLabel.text=@"标准";
            }
        }
        _nameLabel.textAlignment=NSTextAlignmentCenter;
//        _nameLabel.font=[UIFont systemFontOfSize:17*[string floatValue]];
        [cell addSubview:_nameLabel];
    }
    
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
    
        FDAlertView *alert = [[FDAlertView alloc] init];
        ContentView *contentView = [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:nil options:nil].lastObject;
        contentView.frame = CGRectMake(0, 0, 270, 160);
        alert.contentView = contentView;
        [alert show];
        
    }
    if (indexPath.row==1) {
      
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
    if (indexPath.row==2) {
        
        AdviceViewController *adviceVC=[[AdviceViewController alloc]initWithNibName:@"AdviceViewController" bundle:nil];
        [self.navigationController pushViewController:adviceVC animated:YES];
    }
    if (indexPath.row==3) {
        
        AboutViewController *aboutVC=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if (indexPath.row==4) {
        
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

//标准字体
-(void)standard
{
    [SaveTool setObject:@"1" forKey:@"change_font"];
    [SaveTool setObject:@"YES" forKey:@"font_min"];
    [SaveTool setObject:@"NO" forKey:@"font_max"];

    _textFont=@"b";
    _string=APP_Font;
    _nameLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    
    [self.setTableView reloadData];
    
    [UILabel appearance].font = [UILabel changeFont];
}

//大号字体
-(void)bigger
{
    [[NSUserDefaults standardUserDefaults]setObject:@"1.2" forKey:@"change_font"];
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_min"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_max"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _minButton.selected=NO;
    
    _textFont=@"d";
    _string=APP_Font;
    _nameLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
   
    [self.setTableView reloadData];

}

@end
