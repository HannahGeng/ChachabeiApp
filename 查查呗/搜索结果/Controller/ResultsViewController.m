//
//  ResultsViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NSCopying,CityViewCellDelegate>
{
    UISearchBar *_searchBar;
    UILabel *_cityLabel;
    UIImageView *_photoImageView;
    NSArray *_resultsArray;
    UIView *_compayView;
    UIImageView *_imageView;
    UILabel *_companyLabel1;
    UILabel *_companyLabel2;
    UILabel *_companyLabel3;
    
    UIView *_searchView;
    UIView *_cityView;
    UITableView *_cityTableView;
    
    HeadView *_CellHeadView;
    NSArray *_headViewArray;
    NSMutableArray *_dataArray;
    NSArray *_array;
    NSArray *_array1;
    NSArray *_array2;
    NSArray *_array3;
    NSArray *_array4;
    NSArray *_array5;
    NSArray *_array6;
    NSArray *_array7;
    
    UIButton *_viewButton;
    
    UIButton *_contentButton;
    UIView *_backguangView;
    UILabel *_searLabel;
    UILabel *_cityNameLabel;
    UIImageView *_searImageView;
    
    NSString *serchStr;
    NSString * _keycode;
    NSString * _uid;
    NSString * _request;
    NSString * _imei;
    NSString * _keyword;
    NSString * _nonce;
    NSString * _timestamp;
    NSString * _province;
    NSString * _vertifyCode;
    NSString * _timeString;
    NSString * _newnum;
    
    UIView *_validationView;
    UIView *_contentView;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_lineLabel;
    UIImageView *_photoImage;
    UIButton *_shutButton;
    UIButton *_replaceButton;
    UIButton *_confirmButton;
    UITextField *_textField;
    UIImage * _vertifyImage;

    NSOperationQueue *_operationQueue;
    
    AFNetworkReachabilityManager * mgr;
    
    NSString * _company_no;
    MBProgressHUD * mbHud;
}
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (nonatomic,strong) NSArray * companyResult;
@property (nonatomic,strong) NSArray * cityArray;
@property (nonatomic,strong) NSString * newnum;

@end

@implementation ResultsViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCompanyResults];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    //设置内容视图
    [self addContentView];
    
    //加载数据
    [self loadData];
    
}

- (void)loadCompanyResults
{
    AppShare;
    self.companyResult = [CompanyDetail mj_objectArrayWithKeyValuesArray:app.resultArray];
    
    NSMutableArray * resultA = [NSMutableArray array];
    
    for (NSDictionary * dic in app.resultArray) {
        
        CompanyDetail * detail = [[CompanyDetail alloc] initWithDictionary:dic];
        
        [resultA addObject:detail];
    }
    
    self.companyResult = resultA;
    
    NSLog(@"搜索结果：%@",app.resultArray);
}

//设置导航栏
-(void)setNavigationBar
{
    //为导航栏添加左侧按钮
    Backbutton;
}

-(void)backButton
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

//加载数据
-(void)loadData
{
    _headViewArray=[NSArray arrayWithObjects:@"热门",@"华东",@"华南",@"华北",@"西南",@"华中",@"西北",@"东北",nil];
    
    _dataArray=[NSMutableArray array];
    
    _array=[NSArray arrayWithObjects:@"北京",@"上海",@"浙江",@"广东",nil];
    [_dataArray addObject:_array];
    
    _array1=[NSArray arrayWithObjects:@"浙江",@"江苏",@"上海",@"安徽",nil];
    [_dataArray addObject:_array1];
    
    _array2=[NSArray arrayWithObjects:@"海南",@"广西",@"广东",@"福建",nil];
    [_dataArray addObject:_array2];
    
    _array3=[NSArray arrayWithObjects:@"山东",@"山西",@"河北",@"天津",@"北京",nil];
    [_dataArray addObject:_array3];
    
    _array4=[NSArray arrayWithObjects:@"西藏",@"云南",@"贵州",@"四川",@"重庆",nil];
    [_dataArray addObject:_array4];
    
    _array5=[NSArray arrayWithObjects:@"湖南",@"湖北",@"河南",@"江西",nil];
    [_dataArray addObject:_array5];
    
    _array6=[NSArray arrayWithObjects:@"新疆",@"青海",@"甘肃",@"陕西",@"宁夏",nil];
    [_dataArray addObject:_array6];
    
    _array7=[NSArray arrayWithObjects:@"黑龙江",@"吉林",@"辽宁",@"内蒙古",nil];
    [_dataArray addObject:_array7];

    
}
-(void)addContentView
{
    AppShare;
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10.0f,7.0f,[UIUtils getWindowWidth]-130,30.0f)];
    _searchBar.delegate = self;
    _searchBar.layer.masksToBounds=YES;
    _searchBar.layer.cornerRadius=5;
    [_searchBar setTintColor:[UIColor blueColor]];
    [_searchBar setPlaceholder:@"公司/机构名称或个人"];
    _searchBar.text = app.keyword;
//    NSLog(@"~~~~~~~~~~~~~搜索公司关键字：%@",app.keyword);
    
    _viewButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _viewButton.frame=CGRectMake(CGRectGetMaxX(_searchBar.frame), 7, 70, 30);
    _viewButton.backgroundColor=[UIColor clearColor];
    [_viewButton addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];

    //城市
    _cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)+10,5, 40, 35)];
    _cityLabel.text= app.cityname;
    _cityLabel.textColor=[UIColor whiteColor];
    _cityLabel.font=[UIFont systemFontOfSize: 16];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cityLabel.frame), 17, 15, 10)];
    [_photoImageView setImage:[UIImage imageNamed:@"icon_homepage_downArrow"]];
    
    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:_searchBar];
    [searchView addSubview:_viewButton];
    [searchView addSubview:_cityLabel];
    [searchView addSubview:_photoImageView];
    self.navigationItem.titleView = searchView;
    
    self.resultsTableView.dataSource=self;
    self.resultsTableView.delegate=self;
    self.resultsTableView.backgroundColor=[UIColor clearColor];
    self.resultsTableView.scrollEnabled =YES; //设置tableview滚动
    self.resultsTableView.separatorStyle=UITableViewCellEditingStyleNone;
}
//键盘退下事件的处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)cityButtonClick
{
    self.navigationController.navigationBar.hidden = YES;
    _cityView=[[UIView alloc]initWithFrame:CGRectMake(0, -64, [UIUtils getWindowWidth], [UIUtils getWindowHeight])];
    _cityView.backgroundColor=LIGHT_GREY_COLOR;
    [self.view addSubview:_cityView];
    
    _cityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, [UIUtils getWindowWidth], [UIUtils getWindowHeight] - 20) style:UITableViewStylePlain];
    _cityTableView.delegate=self;
    _cityTableView.dataSource=self;
    [_cityView addSubview:_cityTableView];

}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_cityTableView]) {
        return _headViewArray.count;
    }
    if ([tableView isEqual:self.resultsTableView]) {
        return 1;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.resultsTableView]) {
        return self.companyResult.count;
    }
    if ([tableView isEqual:_cityTableView]) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.resultsTableView]) {
        
        ResultsViewCell *cell=[ResultsViewCell cellWithTableView:self.resultsTableView];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.companyDetail = self.companyResult[indexPath.row];
        return cell;
    }
    if ([tableView isEqual:_cityTableView]) {
        
        static NSString *identfire=@"CityCell";
        
        CityViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        if (!cell) {
            
            cell=[[CityViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setContentView:_dataArray[indexPath.section]];
        
        return cell;
     }
     return nil;
}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.resultsTableView]) {
        return 130;
    }
    if ([tableView isEqual:_cityTableView]) {
        return [CityViewCell getHeightWithCityArray:_dataArray[indexPath.section]];
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    [self.view endEditing:YES];
    //点击后变成原色
    [self.resultsTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:self.resultsTableView]) {
        
        if (app.isLogin == YES) {
            app.companyID = app.resultArray[indexPath.row][@"eid"];
            app.companyName = app.resultArray[indexPath.row][@"ent_name"];
            app.companyIndex = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            app.url = app.resultArray[indexPath.row][@"url"];
            
            ContentViewController *contentVC=[[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];

            [self.navigationController pushViewController:contentVC animated:YES];
            
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号登录" message:@"如果想获取更多数据，请先登录" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *naviController=[[UINavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:naviController animated:YES completion:nil];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alert animated:YES completion:^{
            }];

        }
        
    }
}
-(void)SelectCityNameInCollectionBy:(NSString *)cityName
{
    _cityLabel.text=cityName;
    self.navigationController.navigationBar.hidden = NO;
    [_cityView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView]) {
        return 35;
    }
    if ([tableView isEqual:self.resultsTableView]) {
        return 80;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView]) {
        return 0.1;
    }
    if ([tableView isEqual:self.resultsTableView]) {
        return 0.1;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView]) {
        _CellHeadView=[[HeadView alloc]init];
        _CellHeadView.TitleLable.text=_headViewArray[section];
        
        return _CellHeadView;
    }
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [ UIUtils getWindowWidth], 80)];
    headView.backgroundColor=LIGHT_GREY_COLOR;
    [self.resultsTableView addSubview:headView];
    
    if ([tableView isEqual:self.resultsTableView]) {
        
        if (serchStr.length>0) {
            _backguangView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, [UIUtils getWindowWidth], 50)];
            _backguangView.backgroundColor=[UIColor whiteColor];
            [headView addSubview:_backguangView];
            
            _contentButton=[UIButton buttonWithType:UIButtonTypeCustom];
            _contentButton.frame=CGRectMake(0, 15, [UIUtils getWindowWidth], 50);
            _contentButton.backgroundColor=[UIColor clearColor];
            [_contentButton addTarget:self action:@selector(contentButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.resultsTableView addSubview:_contentButton];
            
            _searLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 50, 30)];
            _searLabel.text=@"搜索：";
            _searLabel.font=[UIFont systemFontOfSize:16];
            _searLabel.textAlignment=NSTextAlignmentCenter;
            [_backguangView addSubview:_searLabel];
            
            _cityNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searLabel.frame), 10, 100, 30)];
            _cityNameLabel.text=_searchBar.text;
            _cityNameLabel.font=[UIFont systemFontOfSize:16];
            [_backguangView addSubview:_cityNameLabel];
            
            _searImageView=[[UIImageView alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-45, 10, 30, 30)];
            _searImageView.image=[UIImage imageNamed:@"search_change.png"];
            [_backguangView addSubview:_searImageView];
            return headView;

        }else{
            _compayView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, [UIUtils getWindowWidth], 50)];
            _compayView.backgroundColor=[UIColor whiteColor];
            [headView addSubview:_compayView];
            
            _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
            _imageView.image=[UIImage imageNamed:@"app27.png"];
            [_compayView addSubview:_imageView];
            
            _companyLabel1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 10, 50, 30)];
            _companyLabel1.text=@"查到了";
            _companyLabel1.font=[UIFont systemFontOfSize:16];
            [_compayView addSubview:_companyLabel1];
            
            _companyLabel2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_companyLabel1.frame)+5, 10, 40, 30)];
            _companyLabel2.text= [NSString stringWithFormat:@"%ld",(unsigned long)self.companyResult.count];
            _companyLabel2.textAlignment = NSTextAlignmentCenter;
            _companyLabel2.textColor=[UIColor redColor];
            _companyLabel2.font=[UIFont systemFontOfSize:16];
            [_compayView addSubview:_companyLabel2];
            
            _companyLabel3=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_companyLabel2.frame)+5, 10, 60, 30)];
            _companyLabel3.text=@"家企业";
            _companyLabel3.font=[UIFont systemFontOfSize:16];
            [_compayView addSubview:_companyLabel3];
            
            return headView;

        }
    }

    return nil;
}

#pragma mark - 验证码图片
- (void)createVertifyImage
{
    AppShare;
    _validationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight])];
    UITapGestureRecognizer *tapContentGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [_validationView addGestureRecognizer:tapContentGesture];
    
    [_validationView setBackgroundColor:LIGHT_OPAQUE_BLACK_COLOR];
    self.tabBarController.tabBar.hidden=YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_validationView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(30, ([UIUtils getWindowHeight]-400)/2, [UIUtils getWindowWidth]-60, 250)];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    _contentView.layer.cornerRadius=5;
    [_validationView addSubview:_contentView];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    _titleLabel.text=@"查询验证码";
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.font=[UIFont systemFontOfSize:17];
    [_contentView addSubview:_titleLabel];
    
    _shutButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _shutButton.frame=CGRectMake([UIUtils getWindowWidth]-95, 17, 15, 15);
    [_shutButton setBackgroundImage:[UIImage imageNamed:@"verification_close.png"] forState:UIControlStateNormal];
    [_shutButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_shutButton];
    
    _lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, [UIUtils getWindowWidth]-60, 1)];
    _lineLabel.backgroundColor=[UIColor lightGrayColor];
    [_contentView addSubview:_lineLabel];
    
    _photoImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_lineLabel.frame)+10, 150, 40)];
    _photoImage.backgroundColor=[UIColor yellowColor];
    [_contentView addSubview:_photoImage];
    
    NSData * imageData = [[NSData alloc] initWithBase64EncodedString:app.vertifyImage options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage * vertifyImage = [UIImage imageWithData:imageData];
    
//    NSLog(@"vertifyImage: %@",vertifyImage);
    
    _photoImage.image=vertifyImage;
    
    _replaceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _replaceButton.frame=CGRectMake(CGRectGetMaxX(_photoImage.frame)+5, CGRectGetMaxY(_lineLabel.frame)+15, 60, 30);
    [_replaceButton setTitle:@"换一个" forState:UIControlStateNormal];
    [_replaceButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateNormal];
    [_replaceButton addTarget:self action:@selector(replaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_replaceButton];
    
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_photoImage.frame)+15, [UIUtils getWindowWidth]-120, 40)];
    _textField.placeholder=@"  输入图片中的汉字或算术题计算结果";
    _textField.font=[UIFont systemFontOfSize:15];
    _textField.layer.cornerRadius=5;
    _textField.layer.borderWidth=1;
    _textField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _textField.backgroundColor=[UIColor whiteColor];
    [_contentView addSubview:_textField];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_textField.frame)+10, [UIUtils getWindowWidth]-160, 20)];
    //            _nameLabel.text=@"你输入的验证码有误，请重新输入。";
    _nameLabel.font=[UIFont systemFontOfSize:12];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.textColor=[UIColor redColor];
    [_contentView addSubview:_nameLabel];
    
    _confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame=CGRectMake(0, 200, [UIUtils getWindowWidth]-60, 50);
    _confirmButton.backgroundColor=[UIColor orangeColor];
    _confirmButton.layer.cornerRadius=5;
    [_confirmButton setBackgroundImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_confirmButton];
    
    [_textField becomeFirstResponder];
    
}

#pragma mark - 搜索按钮点击事件
-(void)contentButtonClick
{
    [self.view endEditing:YES];
    
    AppShare;
    if ([_cityLabel.text isEqualToString:@"全国"]) {
        
        MBhud(@"请选择城市");
        
    }else{
        
        if ([serchStr containsString:@" "]){
            
            MBhud(@"关键字格式错误");
            
        }else{
         
            app.cityname = _cityLabel.text;
            
            app.historyCompany = serchStr;
            app.provinceName =_cityLabel.text;
//            NSLog(@"省份名:%@",app.provinceName);
            
            if (app.isLogin == YES) {//登录状态
                
                //keycode
                _keycode = app.loginKeycode;
//                NSLog(@"keycode:%@",_keycode);
                
                //六位随机数
                _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
                
                //关键字
                NSString * keywordStr = serchStr;
                _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
                
                //时间戳
                loginTimeStr;
                
                //省份代码
                //读取plist文件
                NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
                
                self.cityArray = [NSArray arrayWithContentsOfFile:file];
                
                for (int i = 0; i < self.cityArray.count; i++) {
                    
                    if ([_cityLabel.text isEqualToString:self.cityArray[i][@"city"]]) {
                        
                        app.province = self.cityArray[i][@"num"];
                    }
                    
                }
                
                _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:_keycode]];
                
                NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",app.uid,@"uid",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.loginKeycode]],@"imei",app.request,@"request", nil];
                
                //监控网络状态
                mgr = [AFNetworkReachabilityManager sharedManager];
                [mgr startMonitoring];
                [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    
                    if (status != 0) {
                        
                        mbHUDinit;
                        
                        [[HTTPSessionManager sharedManager] POST:Company_Search_URL parameters:pDic result:^(id responseObject, NSError *error) {

                            NSLog(@"搜索结果:%@",responseObject);
                            
                            app.resultArray = responseObject[@"result"];
                            
                            if ([responseObject[@"status"] integerValue] == 1) {
                                
                                hudHide;
                                
                                if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {//有验证码
                                    
                                    if ([responseObject[@"result"][@"image"] isEqual:[NSNull null]]) {//验证码为空

                                        MBhud(@"暂无搜索结果");
                                        
                                    }else{//验证码不为空
                                        
                                        app.isVertify = YES;
                                        app.vertifyImage = responseObject[@"result"][@"image"];
                                        
                                        [self createVertifyImage];
                                        
                                    }
                                    
                                }else//无验证码
                                {
                                    hudHide;
                                    app.isVertify = NO;
                                    [_validationView removeFromSuperview];
                                    app.resultArray = responseObject[@"result"];
                                    
                                    [self loadCompanyResults];
                                    [self.resultsTableView reloadData];
                                }
                                
                            }else{
                                hudHide;
                                MBhud(@"暂无搜索结果");
                            }
                            
                            app.request = responseObject[@"response"];
                            

                        }];
                        
                    }else{
                        
                       noWebhud;
                    }
                }];
                
            }else{//未登陆
                
                //keycode
                _keycode = app.noLoginKeycode;
//                NSLog(@"未登陆的keycode:%@",_keycode);
                
                //request
                _request = app.request;
                
                //六位随机数
                _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
                
                //关键字
                NSString * keywordStr = serchStr;
                _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
                
                //时间戳
                NSDate *  senddate=[NSDate date];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"YYYYMMddmmss"];
                
                _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:_keycode]];
                
//                NSLog(@"locationString:%@",_timeString);
                
                //省份代码
                //读取plist文件
                NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
                
                self.cityArray = [NSArray arrayWithContentsOfFile:file];
                
                for (int i = 0; i < self.cityArray.count; i++) {
                    
                    if ([_cityLabel.text isEqualToString:self.cityArray[i][@"city"]]) {
                        
                        app.province = self.cityArray[i][@"num"];
                    }
                    
                }
                
                _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:_keycode]];
                
                NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",_request,@"request",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",_request,@"request", nil];
                
                //监控网络状态
                mgr = [AFNetworkReachabilityManager sharedManager];
                [mgr startMonitoring];
                [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    
                    if (status != 0) {
                        
                        mbHUDinit;
                        
                        [[HTTPSessionManager sharedManager] POST:Company_Search_URL parameters:pDic result:^(id responseObject, NSError *error) {
                            
                            app.resultArray = responseObject[@"result"][@"data"];
                            app.request = responseObject[@"response"];
                            
                            if ([responseObject[@"status"] integerValue] == 1) {
                                
                                hudHide;
                                if ([responseObject[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {//有验证码
                                    
                                    if ([responseObject[@"result"][@"data"][@"image"] isEqual:[NSNull null]]) {//验证码为空
//                                        NSLog(@"空");
                                        MBhud(@"暂无搜索结果");
                                        
                                    }else{//验证码不为空
                                        
                                        app.vertifyImage = responseObject[@"result"][@"data"][@"image"];
                                        
                                        [_textField becomeFirstResponder];
                                        app.isVertify = YES;
                                        [AESCrypt decrypt:responseObject[@"result"][@"image"]];
                                        
                                        [self createVertifyImage];
                      
                                    }
                                    
                                }else{//无验证码
                                    
                                    app.isVertify = NO;
                                    
                                    [_validationView removeFromSuperview];
                                    
                                    [self loadCompanyResults];
                                    [self.resultsTableView reloadData];
                                    
                                }
                                
                            }else{
                                
                                hudHide;
                                MBhud(@"暂无搜索结果");
                            }
                            

                        }];
                        
                    }else{
                        
                        noWebhud;
                        
                    }
                }];
                
            }
            
        }

    }
        
}

-(void)returnText:(ReturnCityName)block
{
    self.returnBlock=block;
}

- (void)removeView
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_contentView setFrame:CGRectMake(0, [UIUtils getWindowHeight], [UIUtils getWindowWidth], SHARE_CONTENT_HEIGHT)];
                     } completion:^(BOOL finished) {
                         [_validationView removeFromSuperview];
                         
                     }];
}

-(void)replaceBtnClick
{
    [_validationView removeFromSuperview];
    [_contentView removeFromSuperview];
    [self contentButtonClick];
    
}

-(void)confirmBtnClick
{
    AppShare;
    
    if (app.isLogin == YES) {//已登陆
        
        //keycode
        _keycode = app.loginKeycode;
//        NSLog(@"keycode:%@",_keycode);
        
        //uid
        _uid = app.uid;
        
        //request
        _request = app.request;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        NSString * keywordStr = serchStr;
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMddmmss"];
        
        _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:_keycode]];
        
//        NSLog(@"timeString:%@",_timeString);
        
        //省份代码
        //读取plist文件
        NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        
        self.cityArray = [NSArray arrayWithContentsOfFile:file];
        
        for (int i = 0; i < self.cityArray.count; i++) {
            
            if ([_cityLabel.text isEqualToString:self.cityArray[i][@"city"]]) {
                
                app.province = self.cityArray[i][@"num"];
            }
            
        }
        
        _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:_keycode]];
        
        //手机唯一识别码
        NSString * imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:_keycode]];
        
        //验证码
        _vertifyCode = _textField.text;
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_uid,@"uid",_timeString,@"timestamp",_nonce,@"nonce",imei,@"imei",_request,@"request",_vertifyCode,@"verifyCode", nil];
        
        [self.view endEditing:YES];
        [_contentView removeFromSuperview];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;
                
                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
//                    NSLog(@"有验证码的搜索结果：%@",responseObject);
                    app.request = responseObject[@"response"];
                    app.resultArray = responseObject[@"result"];
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        [self loadCompanyResults];
                        [self.resultsTableView reloadData];
                        hudHide;
                        [_validationView removeFromSuperview];
                        
                    }else{
                        
                        hudHide;
                        if (_textField.text.length == 0) {
                            _nameLabel.text=@"请输入验证码";
                            
                        }else{
                            
                            [self.view endEditing:YES];
                            [_validationView removeFromSuperview];
                            MBhud(@"暂无搜索结果");
                        }
                    }

                }];
                
            }else{
                
                noWebhud;
            }
        }];
        
    }else{//未登陆
        
        //keycode
        _keycode = app.noLoginKeycode;
//        NSLog(@"keycode:%@",_keycode);
        
        //request
        _request = app.request;
        
              //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        NSString * keywordStr = serchStr;
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMddmmss"];
        
        _timeString = [AESCrypt encrypt:[dateformatter stringFromDate:senddate] password:[AESCrypt decrypt:_keycode]];
        
        //省份代码
        //读取plist文件
        NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        
        self.cityArray = [NSArray arrayWithContentsOfFile:file];
        
        for (int i = 0; i < self.cityArray.count; i++) {
            
            if ([_cityLabel.text isEqualToString:self.cityArray[i][@"city"]]) {
                
                app.province = self.cityArray[i][@"num"];
            }
            
        }
        
        _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:_keycode]];
        
        //验证码
        _vertifyCode = _textField.text;
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",_request,@"request",_vertifyCode,@"verifyCode", nil];
                
        [self.view endEditing:YES];
        [_contentView removeFromSuperview];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;
                
                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
//                    NSLog(@"%@",responseObject);
                    app.request = responseObject[@"response"];
                    app.resultArray = responseObject[@"result"][@"data"];
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        [self.view endEditing:YES];
                        [_validationView removeFromSuperview];

                        [self loadCompanyResults];
                        [self.resultsTableView reloadData];
                        hudHide;

                        [_validationView removeFromSuperview];
                        
                    }else{
                        
                        hudHide;
                        if (_textField.text.length == 0) {
                            _nameLabel.text=@"请输入验证码";
                            
                        }else{
                            
                            [self.view endEditing:YES];
                            [_validationView removeFromSuperview];
                            MBhud(@"暂无搜索结果");
                            
                        }
                    }

                }];
                
            }else{
                
               noWebhud;
            }
        }];
        
    }
    
}

#pragma mark UISearchBarDelegate
//任务编辑文本
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
//开始编辑UISearchBar的textView时
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
}
//要求
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
//当编辑完成之后调用此函数
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}

//当textView的文字改变或者清除的时候调用此方法，搜索栏目前的状态正在编辑，在搜索文字字段中的当前文本
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AppShare;
    
    serchStr=searchText;
    app.keyword = serchStr;
    [self.resultsTableView reloadData];
    
    //读取plist文件
    NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    
    self.cityArray = [NSArray arrayWithContentsOfFile:file];
    
    for (int i = 0; i < _cityArray.count; i++) {
        
        NSDictionary * dic = _cityArray[i];
        NSString *city = dic[@"city"] ;
        if ([searchText containsString:city]) {
            
            if ([city isEqualToString:_cityArray[i][@"city"]]) {
                
                NSString * newNum = [[_cityArray[i][@"num"] substringToIndex:2] stringByAppendingFormat:@"0000"];
                
                app.province = newNum;
            }
        }
        
        for (int i = 0; i < _cityArray.count; i++){
            if ([app.province isEqualToString:_cityArray[i][@"num"] ]) {
                _cityLabel.text = _cityArray[i][@"city"];
            }
        }
    }
    
}

@end
