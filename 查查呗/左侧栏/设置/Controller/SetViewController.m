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
    UIView *_contentView;
    UIButton *_minButton;
    UIButton *_maxButton;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    
    NSString *_string;
    NSString *_maxStr;
    
    NSString *_textFont;
    
    NSString * _uid;
    NSString * _request;
    AppDelegate * app;

}
@property (weak, nonatomic) IBOutlet UITableView *setTableView;

@end

@implementation SetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    //添加内容视图
    [self addContentView];
    //加载数据
    [self loadData];
    
}
//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar;
    self.title=@"设置";
    
}
//添加内容视图
-(void)addContentView
{
    NSString *str=APP_Font;
    if (!str){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if ( ![[NSUserDefaults standardUserDefaults] objectForKey:@"font_min"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_min"];
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_max"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-90, 18, 70, 30)];
    
    self.setTableView.dataSource=self;
    self.setTableView.delegate=self;
    self.setTableView.backgroundColor=[UIColor clearColor];
    self.setTableView.scrollEnabled =NO; //设置tableview不滚动
    self.setTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
}
//加载数据
-(void)loadData
{
    _setInfoArray = @[
//                       @{@"image":[UIImage imageNamed:@"app12.png"],
//                         @"text":@"字体大小"},
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
    if (!cell) {
        cell=[[SetViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.detailTextLabel.textColor=[UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setContentView:_setInfoArray[indexPath.row]];
    
    NSString *string=APP_Font;
    cell.titleLabel.font=[UIFont systemFontOfSize:17*[string floatValue]];
    
//    if (indexPath.row==0) {
//        if ([_textFont isEqualToString:@"b"]) {
//            _nameLabel.text=@"标准";
//        }else{
//            if ([_textFont isEqualToString:@"d"]) {
//                _nameLabel.text=@"大号";
//            }else{
//                _nameLabel.text=@"标准";
//            }
//            
//        }
//        _nameLabel.textAlignment=NSTextAlignmentCenter;
//        _nameLabel.font=[UIFont systemFontOfSize:17*[string floatValue]];
//        [cell addSubview:_nameLabel];
//    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
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
    
//    if (indexPath.row==0) {
//        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight])];
//        UITapGestureRecognizer *tapContentGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
//        [_shareView addGestureRecognizer:tapContentGesture];
//        
//        [_shareView setBackgroundColor:LIGHT_OPAQUE_BLACK_COLOR];
//        self.tabBarController.tabBar.hidden=YES;
//        [[UIApplication sharedApplication].keyWindow addSubview:_shareView];
//        
//        _contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 180, [UIUtils getWindowWidth]-60, 150)];
//        [_contentView setBackgroundColor:[UIColor whiteColor]];
//        _contentView.layer.cornerRadius=5;
//        [_shareView addSubview:_contentView];
//        
//        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth]-60, 50)];
//        _titleLabel.backgroundColor=LIGHT_BLUE_COLOR;
//        _titleLabel.text=@"设置字体大小";
//        _titleLabel.textColor=[UIColor whiteColor];
//        _titleLabel.textAlignment=NSTextAlignmentCenter;
//        _titleLabel.layer.masksToBounds=YES;
//        _titleLabel.layer.cornerRadius=5;
//        _titleLabel.font=[UIFont systemFontOfSize:17];
//        [_contentView addSubview:_titleLabel];
//        
//        _minButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        _minButton.frame=CGRectMake(([UIUtils getWindowWidth]-160)/2, 65, 100, 30);
//        _minButton.backgroundColor=LIGHT_BLUE_COLOR;
//        [_minButton setTitle:@"标准" forState:UIControlStateNormal];
//        
//        _string=APP_Font;
//        _minButton.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
//        NSString *str= [[NSUserDefaults standardUserDefaults] objectForKey:@"font_min"];
//        if ([str isEqualToString:@"YES"]) {
//            _minButton.selected=YES;
//        }else{
//            
//            _minButton.selected=NO;
//        }
//
//        [_minButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_minButton addTarget:self action:@selector(minButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        _minButton.layer.cornerRadius=5;
//        [_contentView addSubview:_minButton];
//        
//        _maxButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        _maxButton.frame=CGRectMake(([UIUtils getWindowWidth]-160)/2, 110, 100, 30);
//        _maxButton.backgroundColor=LIGHT_BLUE_COLOR;
//        [_maxButton setTitle:@"大号" forState:UIControlStateNormal];
//        
//        NSString *string3=APP_Font;
//        _maxButton.titleLabel.font=[UIFont systemFontOfSize:17*[string3 floatValue]];
//        NSString *str1= [[NSUserDefaults standardUserDefaults] objectForKey:@"font_max"];
//        if ([str1 isEqualToString:@"YES"]) {
//            _maxButton.selected=YES;
//        }else{
//            
//            _maxButton.selected=NO;
//        }
//
//        [_maxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_maxButton addTarget:self action:@selector(maxButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        _maxButton.layer.cornerRadius=5;
//        [_contentView addSubview:_maxButton];
//    }
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
-(void)minButtonClick
{
//    NSLog(@"标准");
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_min"];
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_max"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _maxButton.selected=NO;
    
    if ([_minButton isSelected]) {
        _minButton.selected=YES;
    }else{
        _minButton.selected=YES;
    }
    _textFont=@"b";
    _string=APP_Font;
    _nameLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _minButton.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _maxButton.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    [self.setTableView reloadData];

}
-(void)maxButtonClick
{
//    NSLog(@"大号");
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1.2" forKey:@"change_font"];
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"font_min"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"font_max"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _minButton.selected=NO;
    
    if ([_maxButton isSelected]) {
        _maxButton.selected=YES;
    }else{
        _maxButton.selected=YES;
    }
    _textFont=@"d";
    _string=APP_Font;
    _nameLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _minButton.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _maxButton.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    [self.setTableView reloadData];

}
@end
