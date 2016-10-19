//
//  AttentionViewController.m
//  查查呗
//
//  Created by zdzx-008 on 15/11/25.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import "AttentionViewController.h"

@interface AttentionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * selectArr;
    AppDelegate * app;
    NSString * _uid;
    AFNetworkReachabilityManager * mgr;
    UIButton *button;
    BOOL isSelect;
    NSString * _cidStr;
    NSMutableArray * _cidArr;
    NSMutableArray * _deletArrays;
    UIImageView *_imageView;
    UILabel *_label;
    MBProgressHUD * mbHud;
}
@property (weak, nonatomic) IBOutlet UITableView *attentionTableView;
@property (nonatomic,strong) NSMutableArray * companyArray;

@end

@implementation AttentionViewController

static NSString * const CompanyId = @"company";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.attentionTableView.allowsMultipleSelectionDuringEditing = YES;
    self.view.backgroundColor=[UIColor whiteColor];
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    //加载数据
    [self loadData];
    //添加内容视图
    [self addContentView];
    
}

//设置导航栏
-(void)setNavigationBar
{
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏的颜色
    SetNavigationBar(@"我的关注");

    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-35, 0, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"app04.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
-(void)remindButton
{
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"homeView" object:nil];
}
//加载数据
-(void)loadData
{
        app = [AppDelegate sharedAppDelegate];
        _uid = app.uid;

        //封装POST参数
        if (app.isLogin == YES) {
            
            NSArray * attentionArray = [SaveTool objectForKey:@"attentionArray"];
            
            self.companyArray = [attentionModel mj_objectArrayWithKeyValuesArray:attentionArray];
            [self.attentionTableView reloadData];
            
        }else{
            
            self.companyArray = [attentionModel mj_objectArrayWithKeyValuesArray:nil];
            
            [self.attentionTableView reloadData];
            
        }
    
}

//添加内容视图
-(void)addContentView
{
    self.attentionTableView.dataSource=self;
    self.attentionTableView.delegate=self;
    self.attentionTableView.backgroundColor=[UIColor clearColor];
    self.attentionTableView.scrollEnabled =NO; //设置tableview不滚动
    self.attentionTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
    
    if (![app.attentionArray isEqual:@"暂无关注企业"]) {
        
        //注册CompantTableView
        [self.attentionTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ArrayViewCell class]) bundle:nil] forCellReuseIdentifier:CompanyId];
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, [UIUtils getWindowHeight]-113, [UIUtils getWindowWidth] / 3, 50);
        button.backgroundColor=LIGHT_GREY_COLOR;
        [button setTitle:@"全选" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allSeclectButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        [self.attentionTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ArrayViewCell class]) bundle:nil] forCellReuseIdentifier:CompanyId];
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake([UIUtils getWindowWidth] / 3, [UIUtils getWindowHeight]-113, [UIUtils getWindowWidth] / 3, 50);
        button.backgroundColor=LIGHT_GREY_COLOR;
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button setTitle:@"完成" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        [self.attentionTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ArrayViewCell class]) bundle:nil] forCellReuseIdentifier:CompanyId];
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake([UIUtils getWindowWidth] / 3 * 2, [UIUtils getWindowHeight]-113, [UIUtils getWindowWidth] / 3, 50);
        button.backgroundColor=LIGHT_GREY_COLOR;
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }else{
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-50)/2, 150,50, 50)];
        _imageView.image=[UIImage imageNamed:@"app24.png"];
        [self.view addSubview:_imageView];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-130)/2, CGRectGetMaxY(_imageView.frame)+10, 130, 30)];
        _label.text=@"暂无关注企业";
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:_label];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 20)];
        view.backgroundColor=LIGHT_GREY_COLOR;
        
    }
    
}

- (void)allSeclectButton
{
    
    if (self.attentionTableView.isEditing == YES) {

        if (app.attentionArray.count == 0) {
            
            MBhud(@"已全部删除");
            
        }else{
            
            for (int i = 0; i < self.companyArray.count; i++) {
                
                NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                
                [self.attentionTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                
                [_deletArrays addObjectsFromArray:app.attentionArray];
            }

        }
        
    }else{
        
        MBhud(@"请点击编辑模式");
    }
}

- (void)removeButton
{
    app = [AppDelegate sharedAppDelegate];
    
    NSArray * indexpaths = [self.attentionTableView indexPathsForSelectedRows];
   
    //遍历所有的行号
    _deletArrays = [NSMutableArray array];
    NSMutableArray * deletmodels = [NSMutableArray array];

    for (NSIndexPath * path in indexpaths) {
        [deletmodels addObject:self.companyArray[path.row]];
        [_deletArrays addObject:app.attentionArray[path.row]];
    }
    
    NSMutableArray * cidArr = [NSMutableArray array];
    
    for (int i = 0; i < _deletArrays.count; i++) {
        _cidStr = [NSString stringWithFormat:@"%@",_deletArrays[i][@"cid"]];
    
        [cidArr addObject:_cidStr];
        
    }
    _cidArr = cidArr;
    
    //数组转成json格式
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:_cidArr options:0 error:nil];
    
    NSString * cidStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self.companyArray removeObjectsInArray:deletmodels];

//    NSLog(@"删除后的数组:%@",self.companyArray);
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",cidStr,@"cids", nil];
    
    [[HTTPSessionManager sharedManager] POST:cancel_attention parameters:pdic result:^(id responseObject, NSError *error) {
        
        MBhud(responseObject[@"result"]);

        app.request = responseObject[@"response"];
        
    }];

    //刷新表格
    [self.attentionTableView reloadData];
}

-(void)editButton:(id)sender
{
    UIButton * button = (UIButton *)sender;
    button.selected = !button.selected;
    [self.attentionTableView setEditing:!self.attentionTableView.isEditing animated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArrayViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CompanyId];
    cell.attention = self.companyArray[indexPath.row];
    
    return cell;

}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"%ld",self.attentionTableView.isEditing);
    if ([self.attentionTableView isEditing] == YES) {
        
//        NSLog(@"%ld",(long)indexPath.row);
        
        _cidStr = app.attentionArray[indexPath.row][@"cid"];
        
//        NSLog(@"选择删除的数组:%@",_cidStr);

    }else{

        //点击后变成原色
        [self.attentionTableView deselectRowAtIndexPath:indexPath animated:YES];
        app.companyID = app.attentionArray[indexPath.row][@"cid"];
        app.companyName = app.attentionArray[indexPath.row][@"cname"];
//        NSLog(@"被选中的企业ID:%@",app.companyID);
        
        ContentViewController *contentVC=[[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
        [self.navigationController pushViewController:contentVC animated:YES];
    
    }
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     return UITableViewCellEditingStyleDelete;

}

@end
