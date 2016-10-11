//
//  SearchView.h
//  查查呗
//
//  Created by zdzx-008 on 16/10/11.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

+ (instancetype)searchV;

+ (instancetype)showInpoint:(CGPoint)point;

@end
