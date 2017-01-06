//
//  BarcodeViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/12/28.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "BarcodeViewController.h"

@interface BarcodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrDown;
    NSTimer *timer;
    UIView *backView;
    
    NSString *_carId;
    NSString *_userId;
    NSString *_activityId;
    AppDelegate * app;
}
@property (strong ,nonatomic ) AVCaptureDevice *device;

@property (strong , nonatomic ) AVCaptureDeviceInput *input;

@property (strong , nonatomic ) AVCaptureMetadataOutput *output;

@property (strong , nonatomic ) AVCaptureSession *session;

@property (strong , nonatomic ) AVCaptureVideoPreviewLayer *preview;

@property(strong,nonatomic)UIImageView *line;

@end

@implementation BarcodeViewController
-(void)viewDidAppear:(BOOL)animated
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusDenied)
        
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无法访问通讯录" message:@"请到“设置->隐私->相机”中将toon设置为允许访问相机！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else{
        [self setupCamera];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationBar];

    [self initNav];
    [self initOpaqueView];
    [self initBackView];

}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    SetNavigationBar(@"二维码");

    //为导航栏添加左侧按钮
    Backbutton;
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initNav
{
    self.navigationItem.title=@"二维码";
}

-(void)initOpaqueView
{
    backView=[[UIView alloc]initWithFrame:CGRectMake(leftright, topH, Size, Size)];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(leftright+5, 0, backView.frame.size.width-10, topH)];
    topView.backgroundColor=LIGHT_OPAQUE_BLACK_COLOR;
    [self.view addSubview:topView];
    
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(leftright+5, CGRectGetMaxY(backView.frame)-6, backView.frame.size.width-10, 800)];
    downView.backgroundColor=LIGHT_OPAQUE_BLACK_COLOR;
    [self.view addSubview:downView];
    
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0,0,leftright+5, screen_height)];
    leftView.backgroundColor=LIGHT_OPAQUE_BLACK_COLOR;
    [self.view addSubview:leftView];
    
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backView.frame)-5,0,leftright+5, screen_height)];
    rightView.backgroundColor=LIGHT_OPAQUE_BLACK_COLOR;
    [self.view addSubview:rightView];
    
}
-(void)initBackView
{
    [self.view addSubview:backView];
    
    UIImageView *topImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Size, 28)];
    topImage.image=[UIImage imageNamed:@"newbarcode_scan_box_top"];
    [backView addSubview:topImage];
    
    UIImageView *midImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 28, Size, Size-28*2)];
    midImage.image=[UIImage imageNamed:@"newbarcode_scan_box_mid"];
    [backView addSubview:midImage];
    
    UIImageView *bottomIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, Size-28, Size, 28)];
    bottomIamge.image=[UIImage imageNamed:@"newbarcode_scan_box_bottom"];
    [backView addSubview:bottomIamge];
    
    
    self.line=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, Size-10, 10)];
    self.line.image=[UIImage imageNamed:@"newbarcode_scan_line"];
    [backView addSubview:self.line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.04 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}
-(void)setupCamera
{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(_device == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未检测到相机" message:@"请检查相机设备是否正常" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
        return ;
    }
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //限制扫描区域（上左下右）
    
    [ _output setRectOfInterest : CGRectMake (( screen_height/2-Size/2) / screen_height ,(screen_width/2-Size/2 )/ screen_width , Size /screen_height , Size / screen_width)];
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    // 条码类型AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //_preview.frame =CGRectMake(leftright,top,Size,Size);
    _preview.frame =CGRectMake(0,0,screen_width,screen_height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
//    [self.view.layer addSublayer:self.output];
//    self.output = _output;
    // Start
    [_session startRunning];
}
-(void)animation1
{
    self.line.frame=CGRectMake(5, 2*num, Size-10, 10);
    if (2*num>=Size-10-10) {
        num=0;
    }
    num++;
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{
    app = [AppDelegate sharedAppDelegate];
    
    if ([metadataObjects count ] > 0 )
    {
            
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        // 停止扫描
        [self.session stopRunning];

        CodeController * code = [[CodeController alloc] init];
        
        [self.navigationController pushViewController:code animated:YES];
        
        app.urlStr = object.stringValue;
        
        }else{
            
    }

    [self.session stopRunning];
}

@end
