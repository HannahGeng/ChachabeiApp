//
//  FilpTableView.h
//  查查呗
//
//  Created by zdzx-008 on 15/11/30.
//  Copyright © 2015年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipTableViewDelegate <NSObject>
/**
 滑动回调
 
 @param index 对应的下标（从1开始）
 */
-(void)scrollChangeToIndex:(NSInteger)index;
@end

@interface FlipTableView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
/**
 存放对应的内容控制器
 */
@property (nonatomic,strong)NSMutableArray *dataArray;
/**
 delegate
 */
@property (nonatomic,assign)id<FlipTableViewDelegate> delegate;
/**
 Initialization
 @return instance
 */
-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)contentArray;
/**
 手动选中某个页面
 
 @param index 默认为1（即从1开始）
 */
-(void)selectIndex:(NSInteger)index;

@end
