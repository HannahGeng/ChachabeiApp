//
//  AppDelegate.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/24.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "MMDrawerController.h"
#import "CCBTabBarView.h"

@class CompanyDetail;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MMDrawerController *drawerController;

+ (instancetype)sharedAppDelegate;

/** 上一次接口数据返回的request */
@property (strong,nonatomic)NSString * request;
/** 企业数组的行号 */
@property (strong,nonatomic)NSString * companyIndex;
/** 点击企业的ID */
@property (strong,nonatomic)NSString * companyID;
/** 企业数组 */
@property (strong,nonatomic)NSMutableArray * companyArray;

/** 搜索数组 */
@property (nonatomic,strong) NSArray * resultArray;

/** 热门企业数组 */
@property (nonatomic,strong) NSArray * hotCompanyArray;

/** 关注企业数组 */
@property (nonatomic,strong) NSArray * attentionArray;

/** 登陆成功时获取到的keycode */
@property (strong,nonatomic)NSString * loginKeycode;

/** 登陆成功后返回的 */
@property (strong,nonatomic)NSString * uid;

/** 版本keycode */
@property (strong,nonatomic)NSString * keycode;

/** 用户名 */
@property (strong,nonatomic)NSString * username;

/** 电话号码 */
@property (strong,nonatomic)NSString * phonenum;

/** 密码 */
@property (strong,nonatomic)NSString * password;

/** 邮箱 */
@property (strong,nonatomic)NSString * email;

/** 未登录用户的keycode */
@property (strong,nonatomic)NSString * noLoginKeycode;

/** 判断用户是否登陆 */
@property (nonatomic,assign)BOOL isLogin;

/** 企业详情 */
@property (nonatomic,strong)NSDictionary * companyDetailContent;

/** 企业基本信息 */
@property (nonatomic,strong)NSDictionary * basicInfo;

/** 是否有验证码 */
@property (nonatomic,assign) BOOL isVertify;

/** 省份 */
@property (nonatomic,strong) NSString * province;

/** url */
@property (nonatomic,strong) NSString * url;

/** 公司名称 */
@property (nonatomic,strong) NSString * companyName;

//关注公司状态
@property (nonatomic,assign) BOOL focusStatus;

/** 公司输入关键字 */
@property (nonatomic,strong) NSString * keyword;

/** 城市名 */
@property (nonatomic,strong) NSString * cityname;

@property (nonatomic,strong) UITextField * phoneTextField;

@property (nonatomic,strong) UITextField * passTextField;

/** 网络状态 */
@property (assign,nonatomic) int * statu;

/** 搜索历史 */
@property (nonatomic,strong) NSString * historyCompany;

/** 省份名 */
@property (nonatomic,strong) NSString * provinceName;

/** 搜索历史数组 */
@property (nonatomic,strong) NSArray * historys;

/** 二维码扫描的url */
@property (nonatomic,strong) NSString * urlStr;

/** 是否选择城市 */
@property (nonatomic,assign) BOOL isSelcted;

/** 消息盒子数组 */
@property (nonatomic,strong) NSArray * messageArray;

/** 验证码 */
@property (nonatomic,strong) NSString * vertifyImage;

/** uuid */
@property (nonatomic,strong) NSString * app_uuid;

@property (nonatomic,assign) NSInteger historyIndex;

/** 随机数 */
@property (nonatomic,strong) NSString * nonce;

/** 企业模型 */
@property (nonatomic,strong) CompanyDetail * companyModel;

/** 发送的邮箱地址 */
@property (nonatomic,strong) NSString * sendEmail;

@property (nonatomic,assign) NSInteger selBtnIndex;

@property (nonatomic,assign) NSInteger selConIndex;

@property (nonatomic,strong) NSArray * shareHolderArray;

@property (nonatomic,strong) NSArray * memberArray;

@property (nonatomic,strong) NSArray * branchs;

@property (nonatomic,strong) NSArray * changes;

@property (nonatomic,strong) NSArray * nameArr;

@property (nonatomic,strong) NSArray * dataArr;

/** cityArray */
@property (nonatomic,strong) NSArray * cityArray;

@property (nonatomic,assign) BOOL isFocus;

@property (nonatomic,strong) UIButton * focusButton;

@property (nonatomic,strong) CCBTabBarView * tabView;

@property (nonatomic,strong) NSArray * yearArr;

@end

