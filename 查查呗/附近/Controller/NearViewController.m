//
//  NearViewController.m
//  查查呗
//
//  Created by zdzx-008 on 16/1/12.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "NearViewController.h"

@interface NearViewController ()<UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    UISearchBar *_searchBar;
    UIImageView *_photoImageView;
    UIImageView * _imageView;
    UILabel * _label;
    
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    CLLocationManager *locationManager;
    double _latA;
    double _lonA;
}

@property (weak, nonatomic) IBOutlet UITableView *nameTableView;

@end

@implementation NearViewController
//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 3, [UIUtils getWindowWidth], CGRectGetMidY(self.nameTableView.frame)-100)];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel=16;//地图级别
    [self.view addSubview:_mapView];
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    [_mapView updateLocationViewWithParam:displayParam];
    
    //添加内容视图
    [self addContentView];
}
//设置导航栏
-(void)setNavigationBar
{
    self.navigationItem.title = @"附近的企业";
    SetNavigationBar;
    //为导航栏添加左侧按钮
    Backbutton;
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-35, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

//添加内容视图
-(void)addContentView
{
    //导航条的搜索条
//    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10.0f,7.0f,[UIUtils getWindowWidth]-130,30.0f)];
//    _searchBar.delegate = self;
//    _searchBar.layer.masksToBounds=YES;
//    _searchBar.layer.cornerRadius=5;
//    [_searchBar setTintColor:[UIColor blueColor]];
//    [_searchBar setPlaceholder:@"输入要查找的公司名或商家名"];
    
    //将搜索条放在一个UIView上
//    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 44)];
//    searchView.backgroundColor = [UIColor clearColor];
//    [searchView addSubview:_searchBar];
//    [searchView addSubview:_photoImageView];
//    self.navigationItem.titleView = searchView;
    
    self.nameTableView.dataSource=self;
    self.nameTableView.delegate=self;
    self.nameTableView.backgroundColor=[UIColor clearColor];
    self.nameTableView.scrollEnabled =NO; //设置tableview滚动
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.nameTableView.frame.size.width)/2, 120,50, 50)];
    _imageView.image=[UIImage imageNamed:@"app24.png"];
    [self.nameTableView addSubview:_imageView];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake((self.nameTableView.frame.size.width - 50)/2, CGRectGetMaxY(_imageView.frame)+10, 100, 30)];
    _label.text=@"无结果";
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:14];
    [self.nameTableView addSubview:_label];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
    view.backgroundColor=LIGHT_GREY_COLOR;

}
-(void)remindButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

-(void)backButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageViewCell *cell=[MessageViewCell cellWithTableView:self.nameTableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
//    int i=(int)indexPath.row+1;
    
//    cell.numberLabel.text=[NSString stringWithString:@"%d",indexPath.row+1];
//    cell.numberLabel.text=[NSString stringWithFormat:@"%d.",i];

    return cell;
}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击后变成原色
    [self.nameTableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 65)];
    headView.backgroundColor=LIGHT_BACKGROUND_COLOR;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 22, 20, 20)];
    imageView.image=[UIImage imageNamed:@"appShare.png"];
    [headView addSubview:imageView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(50, 17, 190, 30)];
    label1.text=@"找到附近的诚信企业/商家共";
    label1.textColor=[UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:15];
    [headView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(240, 17, 30, 30)];
    label2.text=@"---";
    label2.textColor=[UIColor orangeColor];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.font=[UIFont systemFontOfSize:15];
    [headView addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(270, 17, 50, 30)];
    label3.text=@"个结果";
    label3.textColor=[UIColor whiteColor];
    label3.font=[UIFont systemFontOfSize:15];
    [headView addSubview:label3];

    return headView;
}
#pragma mark mapViewDelegate 代理方法
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
//    NSLog(@"start locate");
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _latA=userLocation.location.coordinate.latitude;
    _lonA=userLocation.location.coordinate.longitude;

    [_mapView updateLocationData:userLocation];
    
//    for (int i = 0; i < 10; i++) {
//        // 添加一个PointAnnotation
//        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//        CLLocationCoordinate2D coor;
//        coor.latitude = _latA+i*4.50000;
//        coor.longitude = _lonA+i*2.30000;
//        annotation.coordinate = coor;
//        [_mapView addAnnotation:annotation];
//    }
    
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
//    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
//    NSLog(@"location error");
}
#pragma mark - BMKMapViewDelegate

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
//    if ([view isKindOfClass:[ClusterAnnotationView class]]) {
//        ClusterAnnotation *clusterAnnotation = (ClusterAnnotation*)view.annotation;
//        if (clusterAnnotation.size > 1) {
//            [mapView setCenterCoordinate:view.annotation.coordinate];
//            [mapView zoomIn];
//        }
//    }
}

@end
