//
//  SearchView.m
//  查查呗
//
//  Created by zdzx-008 on 16/10/11.
//  Copyright © 2016年 zdzx. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()

@end

@implementation SearchView

+ (instancetype)searchV
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)showInpoint:(CGPoint)point
{
    SearchView * search = [SearchView searchV];
    
    [KWindow addSubview:search];
    
    search.center = point;
    
    return search;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    
    [searchText addObserver:self forKeyPath:@"k" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    if (searchText.length > 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"keyword" object:nil];
        
    }else{
        
    }
}

@end
