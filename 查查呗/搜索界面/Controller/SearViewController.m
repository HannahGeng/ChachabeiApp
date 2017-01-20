//
//  SearViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/26.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "SearViewController.h"

@interface SearViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,CityViewCellDelegate,UIAlertViewDelegate>
{
    UISearchBar *_searchBar;
    UILabel *_cityLabel;
    UIImageView *_photoImageView;
    NSArray *_searInfoArray;
    UIView * searchView;
    UIButton * removeButton;
    
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
    UIView *_contentView;
    UILabel *_searLabel;
    UILabel *_cityNameLabel;
    UIImageView *_searImageView;
    NSString *serachStr;
    
    NSString * _keycode;
    NSString *_timeString;
    NSString * _keyword;
    NSString * _nonce;
    NSString * _province;
    NSString * _vertifyCode;
    
    UIView *_validationView;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_lineLabel;
    UIImageView *_photoImage;
    UIButton *_shutButton;
    UIButton *_replaceButton;
    UIButton *_confirmButton;
    UITextField *_textField;

    AFNetworkReachabilityManager * mgr;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITableView *searchBarTableView;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *myselfButton;
@property (weak, nonatomic) IBOutlet UIImageView *LineIamgeView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic,strong) NSArray * cityArray;
@property (nonatomic,strong) NSString * newnum;
@property (nonatomic,strong) NSArray * companyArray;
/** attention的model */
@property (nonatomic,strong) attentionModel * model;

@end

@implementation SearViewController

static NSString * const cellIdentifier = @"attention";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationBar];
    
    //搜索框
    [self searchBar];
    
    //加载数据
    [self loadData];
    
    //清空搜索历史按钮
    [self cleanHistory];
    
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _historyButton.selected = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改transform
    [UIView animateWithDuration:duration animations:^{
        
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        removeButton.transform = CGAffineTransformMakeTranslation(0, - ty);
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

#pragma mark - 导航栏
-(void)setNavigationBar
{
    //为导航栏添加左侧按钮
    Backbutton;
}

#pragma mark - 搜索框
- (void)searchBar
{
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10.0f,7.0f,[UIUtils getWindowWidth]-130,30.0f)];
    _searchBar.delegate = self;
    _searchBar.layer.masksToBounds=YES;
    _searchBar.layer.cornerRadius=5;
    [_searchBar setTintColor:[UIColor blueColor]];
    [_searchBar setPlaceholder:@"公司/机构名称或个人"];
    _viewButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _viewButton.frame=CGRectMake(CGRectGetMaxX(_searchBar.frame), 7, 70, 30);
    _viewButton.backgroundColor=[UIColor clearColor];
    
    [_viewButton addTarget:self action:@selector(cityButton) forControlEvents:UIControlEventTouchUpInside];
    
    //城市
    _cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)+10,5, 40, 35)];
    _cityLabel.text=@"全国";
    _cityLabel.textColor=[UIColor whiteColor];
    _cityLabel.font=[UIFont systemFontOfSize: 16];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cityLabel.frame), 17, 15, 10)];
    [_photoImageView setImage:[UIImage imageNamed:@"icon_homepage_downArrow"]];
    
    //将搜索条放在一个UIView上
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:_searchBar];
    [searchView addSubview:_viewButton];
    [searchView addSubview:_cityLabel];
    [searchView addSubview:_photoImageView];
    self.navigationItem.titleView = searchView;

    //searchBar自动弹出键盘
    [_searchBar becomeFirstResponder];
}

#pragma mark - 清空搜索历史Button
- (void)cleanHistory
{
    self.searchBarTableView.backgroundColor=[UIColor clearColor];
    [self.searchBarTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearVC class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    removeButton = [[UIButton alloc] init];
    removeButton.frame = CGRectMake(0, [UIUtils getWindowHeight] - 100, [UIUtils getWindowWidth], 40);
    removeButton.backgroundColor = [UIColor lightGrayColor];
    [removeButton setTitle:@"清空搜索历史" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeResult) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];

}

-(void)backButton
{
    [self.view endEditing:YES];
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

#pragma mark - 搜索历史
- (IBAction)companyClick {
    
    removeButton.hidden = NO;
    
    [self loadData];
    
    _myselfButton.selected=NO;
    
    if ([_historyButton isSelected]) {
        
        _historyButton.selected=YES;
        
    }else{
        
        _historyButton.selected=YES;
    }
    
    _LineIamgeView.frame=CGRectMake(0, 37, [UIUtils getWindowWidth]/2, 3);
}

#pragma mark - 我的关注
- (IBAction)focusClick
{
    removeButton.hidden = YES;
    
    [self loadAttentionCompany];
    
    _historyButton.selected=NO;
    
    if ([_myselfButton isSelected]) {
        
        _myselfButton.selected=YES;
        
    }else{
        
        _myselfButton.selected=YES;
    }
    
    _LineIamgeView.frame=CGRectMake([UIUtils getWindowWidth]/2, 37, [UIUtils getWindowWidth]/2, 3);
}

- (void)loadAttentionCompany
{
    AppShare;
        
    //封装POST参数
    if (app.isLogin == YES) {
        
        _searInfoArray = [attentionModel mj_objectArrayWithKeyValuesArray:app.attentionArray];
            
        [self.searchBarTableView reloadData];
        
    }else{
        
        _searInfoArray = [attentionModel mj_objectArrayWithKeyValuesArray:nil];
        
        [self.searchBarTableView reloadData];
    }

}

#pragma mark - 清空搜索记录
- (void)removeResult
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"确定要删除历史记录吗？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    alert.delegate = self;
    
    [alert show];
}

#pragma mark - alert代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
    
        [[DatabaseManager sharedManger] removeAllCompanys];
        [self loadData];
    }
}

#pragma mark - 加载数据(搜索历史、省份列表)
-(void)loadData
{
    AppShare;
    
    NSMutableArray * dataArr = [NSMutableArray new];
    
    app.keyword = serachStr;
    
    _searInfoArray = [[DatabaseManager sharedManger] getAllCompanys];
    
    for (int i = 0; i < _searInfoArray.count; i++) {
        
        NSString * searchStr = _searInfoArray[i][@"company_name"];
        [dataArr addObject:searchStr];
    }
    
    _searInfoArray = dataArr;
    
    [self.searchBarTableView reloadData];
    
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

#pragma mark - 下拉城市列表城市按钮
-(void)cityButton
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([tableView isEqual:self.searchBarTableView]) {
        return _searInfoArray.count;
    }
    if ([tableView isEqual:_cityTableView]) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.searchBarTableView]) {
        
        if (_historyButton.selected == YES) {
            
            //如果点击的事搜索历史按钮
            SearVC *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.attentionCompanyLabel.text =_searInfoArray[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            return cell;
            
        }else{
            
            //如果是点击我的关注按钮
            SearVC *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.attention =_searInfoArray[indexPath.row];
            return cell;
        }
    }
    if ([tableView isEqual:_cityTableView]) {
        
        static NSString *identfire=@"Cell";
        
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
    
    if ([tableView isEqual:self.searchBarTableView]) {
        return 50;
    }
    if ([tableView isEqual:_cityTableView]) {
        return [CityViewCell getHeightWithCityArray:_dataArray[indexPath.section]];
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    
    AppShare;
    
    //点击后变成原色
    [self.searchBarTableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([tableView isEqual:self.searchBarTableView]) {
        
        if (_historyButton.selected == YES) {
            
            app.historyIndex = indexPath.row;
            
            [self historyCellClick];

        }
        else{
            
            ContentViewController * content = [[ContentViewController alloc] init];
            
            //公司ID
            app.companyID = app.attentionArray[indexPath.row][@"cid"];
            
            app.companyName = app.attentionArray[indexPath.row][@"cname"];

            [self.navigationController pushViewController:content animated:YES];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView]) {
        return 35;
    }
    if ([tableView isEqual:self.searchBarTableView]) {
        
        if (serachStr.length>0) {
            return 80;
        }
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([tableView isEqual:_cityTableView]) {
        
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
    if ([tableView isEqual:self.searchBarTableView]) {
      
        if (serachStr.length>0) {
            
            _backguangView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 80)];
            _backguangView.backgroundColor=LIGHT_GREY_COLOR;
            
            _contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, [UIUtils getWindowWidth], 50)];
            _contentView.backgroundColor=[UIColor whiteColor];
            [_backguangView addSubview:_contentView];

            _contentButton=[UIButton buttonWithType:UIButtonTypeCustom];
            _contentButton.frame=CGRectMake(0, 15, [UIUtils getWindowWidth], 50);
            _contentButton.backgroundColor=[UIColor clearColor];
            [_contentButton addTarget:self action:@selector(contentButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [_backguangView addSubview:_contentButton];
            
            _searLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 50, 30)];
            _searLabel.text=@"搜索：";
            _searLabel.font=[UIFont systemFontOfSize:16];
            _searLabel.textAlignment=NSTextAlignmentCenter;
            [_contentView addSubview:_searLabel];
            
            _cityNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_searLabel.frame), 10, 100, 30)];
            _cityNameLabel.text=_searchBar.text;
            _cityNameLabel.font=[UIFont systemFontOfSize:16];
            [_contentView addSubview:_cityNameLabel];
            
            _searImageView=[[UIImageView alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-45, 10, 30, 30)];
            _searImageView.image=[UIImage imageNamed:@"search_change.png"];
            [_contentView addSubview:_searImageView];
            
            return _backguangView;
         }
    }

    return nil;
}

-(void)SelectCityNameInCollectionBy:(NSString *)cityName
{
    AppShare;
    
    [self.view endEditing:YES];
    self.navigationController.navigationBar.hidden = NO;
    _cityLabel.text=cityName;
    app.cityname = cityName;

    [_cityView removeFromSuperview];

}

-(void)returnText:(ReturnCityName)block
{
    self.returnBlock=block;
}

#pragma mark - SearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AppShare;
    serachStr=searchText;
    app.keyword = serachStr;
    [self.searchBarTableView reloadData];

    //读取plist文件
    NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    
    self.cityArray = [NSArray arrayWithContentsOfFile:file];
    
    for (int i = 0; i < _cityArray.count; i++) {
        
        NSDictionary * dic = _cityArray[i];
        NSString *city = dic[@"city"] ;
        
        if ([searchText containsString:city]) {
            
            if ([city isEqualToString:_cityArray[i][@"city"]]) {
                
              NSString * newNum = [[_cityArray[i][@"num"] substringToIndex:2] stringByAppendingFormat:@"0000"];
                
                _newnum = newNum;
            }
        }
        
        for (int i = 0; i < _cityArray.count; i++){
                
            if ([_newnum isEqualToString:_cityArray[i][@"num"] ]) {
                _cityLabel.text = _cityArray[i][@"city"];
                app.cityname = _cityArray[i][@"city"];
            }
        }
            
    }
}

#pragma mark - “搜索”按钮点击事件
-(void)contentButtonClick
{
    AppShare;
    
    [_searchBar resignFirstResponder];
    
    //省份代码
    //读取plist文件
    NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    
    self.cityArray = [NSArray arrayWithContentsOfFile:file];

    app.cityArray = self.cityArray;
    
    for (int i = 0; i < self.cityArray.count; i++) {
        
        if ([_cityLabel.text isEqualToString:self.cityArray[i][@"city"]]) {
            
            app.province = self.cityArray[i][@"num"];
        }
    }

    [self.view endEditing:YES];
    
    //开始网络请求
    app = [AppDelegate sharedAppDelegate];
    
    if ([_cityLabel.text isEqualToString:@"全国"]) {
        
        MBhud(@"请选择城市");
        
    }else{
    
        if ([serachStr containsString:@" "]){
           
            MBhud(@"关键字格式错误");
            
        }else{
            
            NSMutableArray * dataArr = [NSMutableArray new];
            
            //搜索历史加入数据库
            if (_searInfoArray.count != 0) {//搜索历史不为空
                
                BOOL exist = YES;
                for (int i = 0; i < _searInfoArray.count; i++) {
                    
                    if ([serachStr isEqualToString:_searInfoArray[i]]) {
                        
                        exist = NO;
                        break;
                        
                    }
                    
                }
                
                if (exist) {
                    
                    [[DatabaseManager sharedManger] insertCompanys:serachStr cityName:app.province];
                }
                
                [self loadData];

            }else{//搜索历史为空
                
                BOOL ret = [[DatabaseManager sharedManger] insertCompanys:serachStr cityName:app.province];
                
                if (ret) {
                    
                    _searInfoArray = [[DatabaseManager sharedManger] getAllCompanys];
                    
                    for (int i = 0; i < _searInfoArray.count; i++) {
                        
                        NSString * searchStr = _searInfoArray[i][@"company_name"];
                        [dataArr addObject:searchStr];
                        app.historys = dataArr;
                    }
                    
                    [self loadData];
                }
            }
            
            if (app.isLogin == YES) {//登录状态
                
                //keycode
                _keycode = app.loginKeycode;
                
                //六位随机数
                _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
                
                //关键字
                NSString * keywordStr = serachStr;
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
                            
                            if ([responseObject[@"status"] integerValue] == 1) {
                                
                                hudHide;

                                if ([responseObject[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {//有验证码
                                    
                                    if ([responseObject[@"result"][@"data"][@"image"] isEqual:[NSNull null]]) {//验证码为空
                                        
                                        MBhud(@"暂无搜索结果");
                                        
                                    }else{//验证码不为空
                                        
                                        app.resultArray = responseObject[@"result"];

                                        app.isVertify = YES;
                                        app.vertifyImage = responseObject[@"result"][@"data"][@"image"];
                                        
                                        [self createVertifyImage];
                                        
                                    }
                                    
                                }else//无验证码
                                {
                                    app.resultArray = responseObject[@"result"][@"data"];
                                    
                                    app.dataArr = app.resultArray;
                                    
                                    hudHide;
                                    app.isVertify = NO;
                                    [_validationView removeFromSuperview];
                                    ResultsViewController * result = [[ResultsViewController alloc] init];
                                    [self.navigationController pushViewController:result animated:YES];
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
            
                //六位随机数
                _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
                
                //关键字
                NSString * keywordStr = serachStr;
                _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
                
                //时间戳
                noLoginTimeStr;
                
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
                app.province = _newnum;
                
                NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",app.request,@"request",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei", nil];
                
                //监控网络状态
                mgr = [AFNetworkReachabilityManager sharedManager];
                [mgr startMonitoring];
                [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    
                    if (status != 0) {
                        
                        mbHUDinit;
                        
                        [[HTTPSessionManager sharedManager] POST:Company_Search_URL parameters:pDic result:^(id responseObject, NSError *error) {
                            
                            app.resultArray = responseObject[@"result"][@"data"][@"data"];
                            app.request = responseObject[@"response"];
                            
                            if ([responseObject[@"status"] integerValue] == 1) {
                                
                                hudHide;
                                
                                if ([responseObject[@"result"][@"data"][@"data"] isKindOfClass:[NSDictionary class]]) {//有验证码
                                    
                                    if ([responseObject[@"result"][@"data"][@"data"][@"image"] isEqual:[NSNull null]]) {//验证码为空
                                        MBhud(@"暂无搜索结果");
                                        
                                    }else{//验证码不为空
                                        
                                        app.vertifyImage = responseObject[@"result"][@"data"][@"data"][@"image"];
                                        
                                        [_textField becomeFirstResponder];
                                        
                                        app.isVertify = YES;
                                        [AESCrypt decrypt:responseObject[@"result"][@"image"]];
                                        
                                        [self createVertifyImage];

                                    }
                                    
                                }else{//无验证码
                                    
                                    app.isVertify = NO;
                                    
                                    [_validationView removeFromSuperview];
                                    
                                    ResultsViewController * result = [[ResultsViewController alloc] init];
                                    [self.navigationController pushViewController:result animated:YES];
                                }
                                
                            }else{
                                
                                hudHide;
                                MBhud(@"暂无搜索结果");
                            }

                        }];
                        
                    }else{
                        
                        hudHide;
                        noWebhud;
                    }
                }];
            }
        }
    }
}

#pragma  mark - 搜索历史点击事件
- (void)historyCellClick
{
    AppShare;
    
    [self.view endEditing:YES];
    
    //省份编码
    NSArray * historyArr = [[DatabaseManager sharedManger] getAllCompanys];
    NSString * province = historyArr[app.historyIndex][@"province_name"];
    
    //读取plist文件
    NSString * file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    
    self.cityArray = [NSArray arrayWithContentsOfFile:file];
    
    for (int i = 0; i < self.cityArray.count; i++) {
        
        if ([province isEqualToString:self.cityArray[i][@"num"]]) {
            
            app.cityname = self.cityArray[i][@"city"];
        }
        
    }
    
    //关键字
    NSString * keywordStr = historyArr[app.historyIndex][@"company_name"];
    app.keyword = keywordStr;

    if (app.isLogin == YES) {//登录状态
        
        //keycode
        _keycode = app.loginKeycode;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        loginTimeStr;
        _province = [AESCrypt encrypt:province password:[AESCrypt decrypt:_keycode]];
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",app.uid,@"uid",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.loginKeycode]],@"imei",app.request,@"request", nil];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Search_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        hudHide;
                        
                        app.resultArray = responseObject[@"result"][@"data"];

                        if ([responseObject[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {//有验证码
                            
                            if ([responseObject[@"result"][@"data"][@"image"] isEqual:[NSNull null]]) {//验证码为空

                                MBhud(@"暂无搜索结果");
                                
                            }else{//验证码不为空
                                
                                app.isVertify = YES;
                                app.vertifyImage = responseObject[@"result"][@"data"][@"image"];
                                
                                [self createHistoryVertifyImage];
                            }
                            
                        }else//无验证码
                        {
                            app.isVertify = NO;
                            [_validationView removeFromSuperview];
                            ResultsViewController * result = [[ResultsViewController alloc] init];
                            [self.navigationController pushViewController:result animated:YES];

                        }
                        
                    }else{
                        
                        hudHide;
                        MBhud(@"暂无搜索结果");
                    }
                    
                    app.request = responseObject[@"response"];
                    
                }];
                
            }else{
                
                hudHide;
                noWebhud;
            }
        }];
        
    }else{//未登陆

        //keycode
        _keycode = app.noLoginKeycode;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        noLoginTimeStr;
        
        _province = [AESCrypt encrypt:province password:[AESCrypt decrypt:_keycode]];
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",app.request,@"request",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei", nil];
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Search_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    app.request = responseObject[@"response"];
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        hudHide;
                        app.resultArray = responseObject[@"result"][@"data"][@"data"];

                        if ([responseObject[@"result"][@"data"][@"data"] isKindOfClass:[NSDictionary class]]) {//有验证码
                            
                            if ([responseObject[@"result"][@"data"][@"data"][@"image"] isEqual:[NSNull null]]) {//验证码为空

                                MBhud(@"暂无搜索结果");
                                
                            }else{//验证码不为空
                                
                                app.vertifyImage = responseObject[@"result"][@"data"][@"data"][@"image"];
                                
                                [_textField becomeFirstResponder];
                                
                                app.isVertify = YES;
                                [AESCrypt decrypt:responseObject[@"result"][@"data"][@"data"][@"image"]];
                                
                                [self createHistoryVertifyImage];
                                
                            }
                            
                        }else{//无验证码
                            app.isVertify = NO;
                            
                            [_validationView removeFromSuperview];
                            
                            ResultsViewController * result = [[ResultsViewController alloc] init];
                            [self.navigationController pushViewController:result animated:YES];
                            
                        }
                        
                    }else{
                        
                        hudHide;
                        MBhud(@"暂无搜索结果");
                    }
                    
                }];
                
            }else{
                
                hudHide;
                noWebhud;
                
            }
        }];
        
    }

}

/**
 *键盘退下事件的处理
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
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

- (void)historyReplaceBtnClick
{
    [_validationView removeFromSuperview];
    [_contentView removeFromSuperview];
    [self historyCellClick];
}

#pragma mark - 验证码输入确认
-(void)confirmBtnClick
{
    AppShare;
    
    if (app.isLogin == YES) {//已登陆
        
        //keycode
        _keycode = app.loginKeycode;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        NSString * keywordStr = serachStr;
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        loginTimeStr;
        
        _province = [AESCrypt encrypt:app.province password:[AESCrypt decrypt:_keycode]];
        
        NSString * imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:_keycode]];
        
        //验证码
        _vertifyCode = _textField.text;
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",app.uid,@"uid",_timeString,@"timestamp",_nonce,@"nonce",imei,@"imei",app.request,@"request",_vertifyCode,@"verifyCode", nil];
        
        [self.view endEditing:YES];
        [_contentView removeFromSuperview];
     
        //132132671监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    app.request = responseObject[@"response"];
                    app.resultArray = responseObject[@"result"][@"data"];
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        hudHide;
                        
                        ResultsViewController * result = [[ResultsViewController alloc] init];
                        [self.navigationController pushViewController:result animated:YES];
                        
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
                
                hudHide;
                noWebhud;
            }
        }];
    
    }else{//未登陆
            
            //keycode
            _keycode = app.noLoginKeycode;
        
            //六位随机数
            _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
            
            //关键字
            NSString * keywordStr = serachStr;
            _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
            
            //时间戳
            noLoginTimeStr;
        
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
            
            NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",app.request,@"request",_vertifyCode,@"verifyCode", nil];
        
        [self.view endEditing:YES];
            [_contentView removeFromSuperview];

        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {

                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    app.request = responseObject[@"response"];
                    app.resultArray = responseObject[@"result"][@"data"];
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        hudHide;
                        [self.view endEditing:YES];
                        [_validationView removeFromSuperview];
                        
                        ResultsViewController * result = [[ResultsViewController alloc] init];
                        [self.navigationController pushViewController:result animated:YES];
                        
                        [_validationView removeFromSuperview];
                        
                    }else{
                        
                        hudHide;
                        if (_textField.text.length == 0) {
                            _nameLabel.text=@"请输入验证码";
                            
                        }else{
                            
                            [self.view endEditing:YES];
                            [_validationView removeFromSuperview];
                            
                            MBhud(responseObject[@"result"][@"msg"]);
                            
                        }
                    }

                }];

            }else{
                hudHide;
                noWebhud;
            }
        }];
        
    }
    
}
 
- (void)historyConfirmBtnClick
{
    AppShare;
    
    //省份编码
    NSArray * historyArr = [[DatabaseManager sharedManger] getAllCompanys];
    NSString * province = historyArr[app.historyIndex][@"province_name"];
    
    //关键字
    NSString * keywordStr = historyArr[app.historyIndex][@"company_name"];
    
    app = [AppDelegate sharedAppDelegate];
    
    if (app.isLogin == YES) {//已登陆
        
        //keycode
        _keycode = app.loginKeycode;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        loginTimeStr;
        
        _province = [AESCrypt encrypt:province password:[AESCrypt decrypt:_keycode]];
        
        NSString * imei = [AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:_keycode]];
        
        //验证码
        _vertifyCode = _textField.text;
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",app.uid,@"uid",_timeString,@"timestamp",_nonce,@"nonce",imei,@"imei",app.request,@"request",_vertifyCode,@"verifyCode", nil];
        
        [self.view endEditing:YES];
        [_contentView removeFromSuperview];
       
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
                    
                    app.request = responseObject[@"response"];
                    app.resultArray = responseObject[@"result"][@"data"];
                    
                    app.dataArr = app.resultArray;
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        hudHide;
                        ResultsViewController * result = [[ResultsViewController alloc] init];
                        [self.navigationController pushViewController:result animated:YES];
                        
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
                
                hudHide;
                noWebhud;
            }
        }];
        
    }else{//未登陆
        
        //keycode
        _keycode = app.noLoginKeycode;
        
        //六位随机数
        _nonce = [AESCrypt encrypt:app.nonce password:[AESCrypt decrypt:_keycode]];
        
        //关键字
        _keyword = [AESCrypt encrypt:keywordStr password:[AESCrypt decrypt:_keycode]];
        
        //时间戳
        noLoginTimeStr;
        
        _province = [AESCrypt encrypt:province password:[AESCrypt decrypt:_keycode]];
        
        //验证码
        _vertifyCode = _textField.text;
        
        NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_keyword,@"keyword",_province,@"province",_keycode,@"keycode",_timeString,@"timestamp",_nonce,@"nonce",[AESCrypt encrypt:app.app_uuid password:[AESCrypt decrypt:app.noLoginKeycode]],@"imei",app.request,@"request",_vertifyCode,@"verifyCode", nil];
        
        [self.view endEditing:YES];
        [_contentView removeFromSuperview];
          
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                mbHUDinit;

                [[HTTPSessionManager sharedManager] POST:Company_Vertify_URL parameters:pDic result:^(id responseObject, NSError *error) {
                                        
                    app.request = responseObject[@"response"];
                    
                    if ([responseObject[@"status"] intValue] == 1) {
                        
                        hudHide;
                        app.resultArray = responseObject[@"result"][@"data"][@"data"];

                        app.dataArr = app.resultArray;
                        
                        [self.view endEditing:YES];
                        [_validationView removeFromSuperview];
                        
                        ResultsViewController * result = [[ResultsViewController alloc] init];
                        [self.navigationController pushViewController:result animated:YES];
                        
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
                hudHide;
                noWebhud;
            }
        }];
        
    }

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

- (void)createHistoryVertifyImage
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
    
    _photoImage.image=vertifyImage;
    
    _replaceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _replaceButton.frame=CGRectMake(CGRectGetMaxX(_photoImage.frame)+5, CGRectGetMaxY(_lineLabel.frame)+15, 60, 30);
    [_replaceButton setTitle:@"换一个" forState:UIControlStateNormal];
    [_replaceButton setTitleColor:LIGHT_BLUE_COLOR forState:UIControlStateNormal];
    [_replaceButton addTarget:self action:@selector(historyReplaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
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

    _nameLabel.font=[UIFont systemFontOfSize:12];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.textColor=[UIColor redColor];
    [_contentView addSubview:_nameLabel];
    
    _confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame=CGRectMake(0, 200, [UIUtils getWindowWidth]-60, 50);
    _confirmButton.backgroundColor=[UIColor orangeColor];
    _confirmButton.layer.cornerRadius=5;
    [_confirmButton setBackgroundImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(historyConfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_confirmButton];
    
    [_textField becomeFirstResponder];

}

@end
