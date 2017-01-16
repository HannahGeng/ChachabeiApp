//
//  PersonalViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    AppDelegate * app;
    UIView *_photoView;
    UIView *_nameView;
    UIView *_numberView;
    UIView *_emailView;
    UIView *_passView;
 
    UIButton *_nameButton;
    UIButton *_nameButton1;
    UIButton *_numberButton;
    UIButton *_numberButton1;
    UIButton *_emailButton;
    UIButton *_emailButton1;
    UIButton *_passButton;
    UIButton *_passButton1;
    
    UILabel *_nicknameLabel;
    UILabel *_numberLabel;
    UILabel *_emailLabel;
    UILabel *_passLabel;
    UILabel *emaiLabel;
    UILabel *numbLabel;
    TimerButton *_timeButton;
    
    UIView *_nameContent;
    UIView *_numberContent;
    UIView *_emailContent;
    UIView *_passContent;
    UITextField *_nameTextField;
    /** 输入新手机号 */
    UITextField *_photoTextField;
    /** 输入短信验证码 */
    UITextField *_namberTextField;
    /** 输入新邮箱 */
    UITextField *_emilTextField;
    /** 输入旧密码 */
    UITextField *_passTextField;
    /** 输入新密码 */
    UITextField *_newPass;
    /** 输入确认新密码 */
    UITextField *_confirmPass;
    
    UIImageView *_imageView;
    
    UIButton *_resigtButton;
    
    /** 新邮箱 */
    NSString * _email;
    /** 新昵称 */
    NSString * _nickName;
    NSString * _keycode;
    NSString * _uid;
    NSString * _request;
    UILabel * nameLabel;
    AFNetworkReachabilityManager * mgr;
    NSString * _hudStr;
    MBProgressHUD * mbHud;
}

@property(retain, nonatomic) NSIndexPath *selectIndex;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    leftButton;
    
    //设置导航栏
    [self setNavigationBar];
    //添加内容视图
    [self addContentView];
    //添加昵称视图
    [self addPhotoView];
    //添加手机号视图
    [self addNumberView];
    //添加邮箱视图
    [self addEmailView];
    //添加安全视图
    [self addPassView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - textField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, -120, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"个人中心");
        
    //为导航栏添加左侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-30, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(homeButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)homeButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}

//加载内容视图
-(void)addContentView
{
    _photoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 80)];
    _photoView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_photoView];
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
    //保持圆形头像
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius=25;
    
    NSData *data = [SaveTool objectForKey:@"image"];
    if (!data) {
        _imageView.image=[UIImage imageNamed:@"touxiang.png"];
    }else{
        _imageView.image=[UIImage imageWithData:data];
    }
    [_photoView addSubview:_imageView];
    
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"image" object:nil];

    UILabel *pasLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-115, 5, 70, 80)];
    pasLabel.text=@"设置头像";
    pasLabel.textAlignment=NSTextAlignmentRight;
    pasLabel.font=[UIFont systemFontOfSize:16];
    [_photoView addSubview:pasLabel];

    UIButton *setButton=[UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 20, 15, 10);

    [setButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:setButton];
    
    _passButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    _passButton1.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], 80);
    _passButton1.selected=NO;
    [_passButton1 addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _passButton1.backgroundColor=[UIColor clearColor];
    [_photoView addSubview:_passButton1];

    UIImage *imageNoamal=[UIImage imageNamed:@"Disclosure Indicator2"];
    UIButton *photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 35, 15, 10);
    [photoButton setImage:imageNoamal forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_photoView addSubview:photoButton];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 79, [UIUtils getWindowWidth]-5, 1)];
    label.backgroundColor=LIGHT_GREY_COLOR;
    [_photoView addSubview:label];
    
    UIImage *restrigImage=[UIImage imageNamed:@"exit.png"];
    _resigtButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _resigtButton.frame=CGRectMake(20, 450, [UIUtils getWindowWidth]-40, 50);
    [_resigtButton setImage:restrigImage forState:UIControlStateNormal];
    [_resigtButton addTarget:self action:@selector(resigtButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resigtButton];
    
}

//添加昵称视图
-(void)addPhotoView
{
    app = [AppDelegate sharedAppDelegate];
    
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    _nameView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, [UIUtils getWindowWidth], 50)];
    _nameView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_nameView];

    _nicknameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
    _nicknameLabel.text=@"昵称";
    _nicknameLabel.font=[UIFont systemFontOfSize:16];
    [_nameView addSubview:_nicknameLabel];
    
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-145, 10, 100, 30)];
    app.username = [SaveTool objectForKey:@"username"];
    nameLabel.text = app.username;
    nameLabel.textAlignment=NSTextAlignmentRight;
    nameLabel.font=[UIFont systemFontOfSize:16];
    [_nameView addSubview:nameLabel];

    UIImage *imageNoamal=[UIImage imageNamed:@"Disclosure Indicator2"];
    UIImage *imageSelect=[UIImage imageNamed:@"productdetails_fav3"];
    _nameButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _nameButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 20, 15, 10);
    _nameButton.selected=NO;
    [_nameButton setImage:imageNoamal forState:UIControlStateNormal];
    [_nameButton setImage:imageSelect forState:UIControlStateSelected];
    [_nameView addSubview:_nameButton];
    
    _nameButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    _nameButton1.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], 50);
    _nameButton1.selected=NO;
    [_nameButton1 addTarget:self action:@selector(nameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _nameButton1.backgroundColor=[UIColor clearColor];
    [_nameView addSubview:_nameButton1];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
    label.backgroundColor=LIGHT_GREY_COLOR;
    [_nameView addSubview:label];

}

//添加手机号视图
-(void)addNumberView
{
    app = [AppDelegate sharedAppDelegate];
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    _numberView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50)];
    _numberView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_numberView];
    
    _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
    _numberLabel.text=@"手机号码";
    _numberLabel.font=[UIFont systemFontOfSize:16];
    [_numberView addSubview:_numberLabel];
    
    numbLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-165, 10, 120, 30)];
    numbLabel.text=app.phonenum;
    numbLabel.textAlignment=NSTextAlignmentRight;
    numbLabel.font=[UIFont systemFontOfSize:16];
    [_numberView addSubview:numbLabel];
    
    UIImage *imageNoamal=[UIImage imageNamed:@"Disclosure Indicator2"];
    UIImage *imageSelect=[UIImage imageNamed:@"productdetails_fav3"];
    _numberButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _numberButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 20, 15, 10);
    [_numberButton setImage:imageNoamal forState:UIControlStateNormal];
    [_numberButton setImage:imageSelect forState:UIControlStateSelected];
    [_numberView addSubview:_numberButton];
    
    _numberButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    _numberButton1.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], 50);
    _numberButton1.selected=NO;
    [_numberButton1 addTarget:self action:@selector(numberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _numberButton1.backgroundColor=[UIColor clearColor];
    [_numberView addSubview:_numberButton1];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
    label.backgroundColor=LIGHT_GREY_COLOR;
    [_numberView addSubview:label];

}

//添加邮箱视图
-(void)addEmailView
{
    app = [AppDelegate sharedAppDelegate];
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    
    _emailView=[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50)];
    _emailView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_emailView];

    _emailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
    _emailLabel.text=@"电子邮箱";
    _emailLabel.font=[UIFont systemFontOfSize:16];
    [_emailView addSubview:_emailLabel];
    
    emaiLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-195, 10, 150, 30)];
    emaiLabel.text=app.email;

    emaiLabel.textAlignment=NSTextAlignmentRight;
    emaiLabel.font=[UIFont systemFontOfSize:16];
    [_emailView addSubview:emaiLabel];
    
    UIImage *imageNoamal=[UIImage imageNamed:@"Disclosure Indicator2"];
    UIImage *imageSelect=[UIImage imageNamed:@"productdetails_fav3"];
    _emailButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _emailButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 20, 15, 10);
    [_emailButton setImage:imageNoamal forState:UIControlStateNormal];
    [_emailButton setImage:imageSelect forState:UIControlStateSelected];
    [_emailView addSubview:_emailButton];
    
    _emailButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    _emailButton1.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], 50);
    _emailButton1.selected=NO;
    [_emailButton1 addTarget:self action:@selector(emailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _emailButton1.backgroundColor=[UIColor clearColor];
    [_emailView addSubview:_emailButton1];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
    label.backgroundColor=LIGHT_GREY_COLOR;
    [_emailView addSubview:label];

}

//添加密码视图
-(void)addPassView
{
    _passView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50)];
    _passView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_passView];

    _passLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
    _passLabel.text=@"安全设置";
    _passLabel.font=[UIFont systemFontOfSize:16];
    [_passView addSubview:_passLabel];
    
    UILabel *pasLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-115, 10, 70, 30)];
    pasLabel.text=@"修改密码";
    pasLabel.textAlignment=NSTextAlignmentRight;
    pasLabel.font=[UIFont systemFontOfSize:16];
    [_passView addSubview:pasLabel];
    
    UIImage *imageNoamal=[UIImage imageNamed:@"Disclosure Indicator2"];
    UIImage *imageSelect=[UIImage imageNamed:@"productdetails_fav3"];
    _passButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _passButton.frame=CGRectMake([UIUtils getWindowWidth]-20-15, 20, 15, 10);
    [_passButton setImage:imageNoamal forState:UIControlStateNormal];
    [_passButton setImage:imageSelect forState:UIControlStateSelected];
    [_passView addSubview:_passButton];
    
    _passButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    _passButton1.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], 50);
    _passButton1.selected=NO;
    [_passButton1 addTarget:self action:@selector(passButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _passButton1.backgroundColor=[UIColor clearColor];
    [_passView addSubview:_passButton1];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
    label.backgroundColor=LIGHT_GREY_COLOR;
    [_passView addSubview:label];

}

-(void)passButtonClick
{
    
    if (_passContent) {
        [_passContent removeFromSuperview];

    }
    
    if ([_passButton1 isSelected]) {
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _passButton1.selected=NO;
        _passButton.selected=NO;
        
        _passLabel.text=@"安全设置";
        [_passContent removeFromSuperview];
        
    }else {
        
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 200);
        _passButton1.selected=YES;
        _passButton.selected=YES;
        _nameButton1.selected=NO;
        _nameButton.selected=NO;
        _numberButton1.selected=NO;
        _numberButton.selected=NO;
        _emailButton1.selected=NO;
        _emailButton.selected=NO;
        
        _passLabel.text=@"重置密码";
        
        _passContent=[[UIView alloc]initWithFrame:CGRectMake(0, 50, [UIUtils getWindowWidth], 150)];
        [_passView addSubview:_passContent];

        _passTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        _passTextField.placeholder=@"输入旧密码";
        _passTextField.delegate = self;
        [_passTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_passContent addSubview:_passTextField];

        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, [UIUtils getWindowWidth], 1)];
        label1.backgroundColor=LIGHT_GREY_COLOR;
        [_passContent addSubview:label1];

        _newPass=[[UITextField alloc]initWithFrame:CGRectMake(20, 60, 200, 30)];
        _newPass.placeholder=@"设置新密码";
        _newPass.delegate = self;
        [_newPass setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_passContent addSubview:_newPass];

        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 100, [UIUtils getWindowWidth]-5, 1)];
        label2.backgroundColor=LIGHT_GREY_COLOR;
        [_passContent addSubview:label2];

        _confirmPass=[[UITextField alloc]initWithFrame:CGRectMake(20, 110, 200, 30)];
        _confirmPass.placeholder=@"确认新密码";
        _confirmPass.delegate = self;
        [_confirmPass setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_passContent addSubview:_confirmPass];

        UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn5.frame = CGRectMake([UIUtils getWindowWidth]-20-50, 110, 50, 30);
        [btn5 setTitle:@"确定" forState:UIControlStateNormal];
        [btn5 setTintColor:[UIColor whiteColor]];
        btn5.backgroundColor=GREEN_COLOR;
        btn5.layer.cornerRadius=5;
        
        [btn5 addTarget:self action:@selector(changePass) forControlEvents:UIControlEventTouchUpInside];
        
        [_passContent addSubview:btn5];
        
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(5, 150, [UIUtils getWindowWidth]-5, 1)];
        label3.backgroundColor=LIGHT_GREY_COLOR;
        [_passContent addSubview:label3];

    }
}

-(void)emailButtonClick
{
    
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    if ([_emailButton1 isSelected]) {
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _emailButton1.selected=NO;
        _emailButton.selected=NO;
        
        _emailLabel.text=@"电子邮箱";
        [_emailContent removeFromSuperview];

    }else {
        
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 100);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _emailButton1.selected=YES;
        _emailButton.selected=YES;
        _nameButton1.selected=NO;
        _nameButton.selected=NO;
        _numberButton1.selected=NO;
        _numberButton.selected=NO;
        _passButton1.selected=NO;
        _passButton.selected=NO;
        
        _emailLabel.text=@"绑定邮箱";
        _emailContent=[[UIView alloc]initWithFrame:CGRectMake(0, 50, [UIUtils getWindowWidth], 50)];
        [_emailView addSubview:_emailContent];
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake([UIUtils getWindowWidth]-20-50, 10, 50, 30);
        [btn1 setTitle:@"确认" forState:UIControlStateNormal];
        [btn1 setTintColor:[UIColor whiteColor]];
        btn1.backgroundColor=GREEN_COLOR;
        btn1.layer.cornerRadius=5;
        [btn1 addTarget:self action:@selector(btn2Clink) forControlEvents:UIControlEventTouchUpInside];
        [_emailContent addSubview:btn1];

        _emilTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        _emilTextField.placeholder=@"输入邮箱";
        [_emilTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_emailContent addSubview:_emilTextField];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
        label1.backgroundColor=LIGHT_GREY_COLOR;
        [_emailContent addSubview:label1];
        
    }

}

-(void)numberButtonClick
{
    
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    if ([_numberButton1 isSelected]) {
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _numberButton1.selected=NO;
        _numberButton.selected=NO;
        
        _numberLabel.text=@"手机号码";
        [_numberContent removeFromSuperview];
        
    }else {
        
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 150);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _numberButton1.selected=YES;
        _numberButton.selected=YES;
        _nameButton1.selected=NO;
        _nameButton.selected=NO;
        _emailButton1.selected=NO;
        _emailButton.selected=NO;
        _passButton1.selected=NO;
        _passButton.selected=NO;
        
        _numberLabel.text=@"修改绑定手机号";
        _numberContent=[[UIView alloc]initWithFrame:CGRectMake(0, 50, [UIUtils getWindowWidth], 100)];
        [_numberView addSubview:_numberContent];
        
        _timeButton=[TimerButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame=CGRectMake([UIUtils getWindowWidth]-20-100, 10, 100, 30);
        [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timeButton setTintColor:[UIColor whiteColor]];
        _timeButton.backgroundColor=GREEN_COLOR;
        _timeButton.layer.cornerRadius=5;
        _timeButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_timeButton addTarget:self action:@selector(messageClink) forControlEvents:UIControlEventTouchUpInside];
        [_numberContent addSubview:_timeButton];
        
        
        _photoTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        _photoTextField.placeholder=@"输入手机号";
        [_photoTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_numberContent addSubview:_photoTextField];

        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, [UIUtils getWindowWidth]-5, 1)];
        label2.backgroundColor=LIGHT_GREY_COLOR;
        [_numberContent addSubview:label2];

        _namberTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 60, 200, 30)];
        _namberTextField.placeholder=@"输入短信验证码";
        [_namberTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_numberContent addSubview:_namberTextField];

        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn2.frame = CGRectMake([UIUtils getWindowWidth]-20-50, 60, 50, 30);
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn2 setTintColor:[UIColor whiteColor]];
        btn2.backgroundColor=GREEN_COLOR;
        btn2.layer.cornerRadius=5;
        [btn2 addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [_numberContent addSubview:btn2];
        
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(5, 99, [UIUtils getWindowWidth]-5, 1)];
        label3.backgroundColor=LIGHT_GREY_COLOR;
        [_numberContent addSubview:label3];
        
    }

}

#pragma mark - 短信验证码倒计时
- (void)startTime
{
    [_timeButton setBackgroundColor:[UIColor lightGrayColor]];
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _timeButton.backgroundColor = GREEN_COLOR;
                [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _timeButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeout % 100;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_timeButton setTitle:[NSString stringWithFormat:@"已发送%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _timeButton.userInteractionEnabled = NO;
            });
            
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)nameButtonClick
{
    if (_passContent) {
        [_passContent removeFromSuperview];
        
    }
    if ([_nameButton1 isSelected]) {
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 50);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _nameButton1.selected=NO;
        _nameButton.selected=NO;
        
        _nicknameLabel.text=@"昵称";
        
        [_nameContent removeFromSuperview];
        
    }else {
    
        _nameView.frame=CGRectMake(0, 80, [UIUtils getWindowWidth], 100);
        _numberView.frame=CGRectMake(0, CGRectGetMaxY(_nameView.frame), [UIUtils getWindowWidth], 50);
        _emailView.frame=CGRectMake(0, CGRectGetMaxY(_numberView.frame), [UIUtils getWindowWidth], 50);
        _passView.frame=CGRectMake(0, CGRectGetMaxY(_emailView.frame), [UIUtils getWindowWidth], 50);
        _nameButton1.selected=YES;
        _nameButton.selected=YES;
        _numberButton1.selected=NO;
        _numberButton.selected=NO;
        _emailButton1.selected=NO;
        _emailButton.selected=NO;
        _passButton1.selected=NO;
        _passButton.selected=NO;
        
        _nicknameLabel.text=@"修改昵称";
        
        _nameContent=[[UIView alloc]initWithFrame:CGRectMake(0, 50, [UIUtils getWindowWidth], 50)];
        [_nameView addSubview:_nameContent];
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake([UIUtils getWindowWidth]-20-50, 10, 50, 30);
        [btn1 setTitle:@"确认" forState:UIControlStateNormal];
        [btn1 setTintColor:[UIColor whiteColor]];
        btn1.backgroundColor=GREEN_COLOR;
        btn1.layer.cornerRadius=5;
        [btn1 addTarget:self action:@selector(btn1Clink) forControlEvents:UIControlEventTouchUpInside];
        [_nameContent addSubview:btn1];

        _nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];
        _nameTextField.placeholder=@"输入昵称";
        [_nameTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        [_nameContent addSubview:_nameTextField];
        
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(5, 49, [UIUtils getWindowWidth]-5, 1)];
        label3.backgroundColor=LIGHT_GREY_COLOR;
        [_nameContent addSubview:label3];
    }

}

#pragma mark - 昵称确认按钮
-(void)btn1Clink
{
    app = [AppDelegate sharedAppDelegate];
    //keycode
    _keycode = app.loginKeycode;
    
    //uid
    _uid = app.uid;
    
    //request
    app = [AppDelegate sharedAppDelegate];
    _request = app.request;
    
    //加密昵称和邮箱
    _nickName = [AESCrypt encrypt:_nameTextField.text password:[AESCrypt decrypt:_keycode]];
    _email = [AESCrypt encrypt:_emilTextField.text password:[AESCrypt decrypt:_keycode]];
    
    //参数
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_nickName,@"nickname",_email,@"email",_uid,@"uid",_request,@"request", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:ChangeNickName_URL parameters:pDic result:^(id responseObject, NSError *error) {
                                
                _hudStr = responseObject[@"result"];
                
                MBhud(_hudStr);
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    [self nameButtonClick];
                    nameLabel.text = _nameTextField.text;
                    app.username = nameLabel.text;

                    [SaveTool setObject:nameLabel.text forKey:@"username"];
                    
                }
                app.request = responseObject[@"response"];
            }];
            
        }else{
            
            noWebhud;
        }
    }];
    

}

#pragma mark - 邮箱确认按钮
-(void)btn2Clink
{
    [self.view endEditing:YES];
    app = [AppDelegate sharedAppDelegate];
    //keycode
    _keycode = app.loginKeycode;
    
    //uid
    _uid = app.uid;
    
    //request
    app = [AppDelegate sharedAppDelegate];
    _request = app.request;
    
    //加密昵称和邮箱
    _nickName = [AESCrypt encrypt:_nameTextField.text password:[AESCrypt decrypt:_keycode]];
    _email = [AESCrypt encrypt:_emilTextField.text password:[AESCrypt decrypt:_keycode]];
    
    //参数
    NSDictionary * pDic = [NSDictionary dictionaryWithObjectsAndKeys:_nickName,@"nickname",_email,@"email",_uid,@"uid",_request,@"request", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:ChangeNickName_URL parameters:pDic result:^(id responseObject, NSError *error) {
                
                _hudStr = responseObject[@"result"];
                
                MBhud(_hudStr);

                if ([responseObject[@"status"] integerValue] == 1) {
                    [self emailButtonClick];
                    emaiLabel.text = _emilTextField.text;
                    app.email = emaiLabel.text;
                }
                app.request = responseObject[@"response"];

            }];
     
        }else{
            
            noWebhud;
        }
    }];
    
    
}

#pragma mark - 获取短信验证码
- (void)messageClink
{
    
    [self.view endEditing:YES];
    app =[AppDelegate sharedAppDelegate];

    _uid = app.uid;
    _request = app.request;
    _keycode = app.loginKeycode;
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_request,@"request",[AESCrypt encrypt:_photoTextField.text password:[AESCrypt decrypt:_keycode]],@"telno", nil];
    
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:GetMessageCode_URL parameters:pdic result:^(id responseObject, NSError *error) {
                
                app.request = responseObject[@"response"];
                _hudStr = responseObject[@"result"];

                MBhud(_hudStr);

                if ([responseObject[@"status"] integerValue] == 1) {
                    [self startTime];
                }

            }];

        }else{
            
           noWebhud;
        }
    }];
   
}

#pragma mark - 短信验证码“确定“按钮
- (void)sureClick
{
    
    [self.view endEditing:YES];
    app =[AppDelegate sharedAppDelegate];

    _uid = app.uid;
    _request = app.request;
    _keycode = [AESCrypt decrypt:app.loginKeycode];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_request,@"request",[AESCrypt encrypt:_photoTextField.text password:_keycode],@"telno",[AESCrypt encrypt:_namberTextField.text password:_keycode],@"msgcode", nil];
 
    //监控网络状态
    mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {

            [[HTTPSessionManager sharedManager] POST:InputMessage_URL parameters:pdic result:^(id responseObject, NSError *error) {
                
                _hudStr = responseObject[@"result"];
                MBhud(_hudStr);
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    [self numberButtonClick];
                    
                    numbLabel.text = _nameTextField.text;
                }
                
                app.request = responseObject[@"response"];

            }];
            
        }else{
            
           noWebhud;
        }
    }];
    
}

#pragma mark - 重置密码“确认”按钮
- (void)changePass
{
    app =[AppDelegate sharedAppDelegate];
    _uid = app.uid;
    _request = app.request;
    _keycode = [AESCrypt decrypt:app.loginKeycode];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:_uid,@"uid",_request,@"request",[AESCrypt encrypt:_confirmPass.text password:_keycode],@"newpass",[AESCrypt encrypt:_passTextField.text password:_keycode],@"oldpass", nil];
    
    if (_passTextField.text.length == 0 || _newPass.text.length == 0 || _confirmPass.text.length == 0) {

        MBhud(@"信息不完整");

    }else{
        
        //监控网络状态
        mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {

                if (![_confirmPass.text isEqualToString:_newPass.text]) {
                    
                    MBhud(@"密码输入不一致");
                    
                }else{

                    [[HTTPSessionManager sharedManager] POST:changePass_URL parameters:pdic result:^(id responseObject, NSError *error) {
                        
                        app.request = responseObject[@"response"];
                        
                        _hudStr = responseObject[@"result"];
                        MBhud(_hudStr);
                        
                        if ([responseObject[@"status"] integerValue] == 1) {
                            
                            [self passButtonClick];
                        }
                    }];
                    
                }
                
            }else{
                
                noWebhud;
                
            }
        }];
        
    }
    
}

-(void)resigtButtonClick
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"你确定要退出登录吗？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phonenum"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passnum"];

        LoginViewController *loginVC=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];

    }
}

-(void)photoButtonClick
{
    //创建对象
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    
    //在视图上展示
    [actionSheet showInView:self.view];

}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 相册 0 拍照 1
    switch (buttonIndex) {
        case 0:
            //从相册中读取
            [self readImageFromAlbum];
            break;
        case 1:
            //拍照
            [self readImageFromCamera];
            break;
        default:
            break;
    }
}

//从相册中读取
- (void)readImageFromAlbum {
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)readImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        
        //弹出窗口响应点击事件
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
}

//图片完成之后处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    //image 就是修改后的照片
    //以下是保存文件到沙盒路径下
    //把图片转成NSData类型的数据来保存文件
    NSData *data;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    _imageView.image=[UIImage imageWithData:data];
    [SaveTool setObject:data forKey:@"image"];
    
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
