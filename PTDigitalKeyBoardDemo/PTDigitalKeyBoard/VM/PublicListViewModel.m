//
//  PublicListViewModel.m
//  ExampleProjectDemo
//
//  Created by BlanBok on 2018/1/15.
//  Copyright © 2018年 juyuanGroup. All rights reserved.
//

#import "PublicListViewModel.h"

@implementation PublicListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _page_current = 1;
    }
    return self;
}

- (void)setListView:(UIScrollView *)listView
{
    _listView = listView;
    if ([listView isKindOfClass:[UITableView class]]) {
        ((UITableView*)listView).delegate = self;
        ((UITableView*)listView).dataSource = self;
    }else if ([listView isKindOfClass:[UICollectionView class]])
    {
        ((UICollectionView*)listView).delegate = self;
        ((UICollectionView*)listView).dataSource = self;
    }else{
        return;
    }
}

#pragma mark-tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<PublicListViewModelDelegate> *cell = [tableView dequeueReusableCellWithIdentifier:PublicList_ReuseIdentifier];    
    [self event_listCell:cell upData:self.dataSource[indexPath.item]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark-collectionViewDele
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell<PublicListViewModelDelegate> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublicList_ReuseIdentifier forIndexPath:indexPath];
    [self event_listCell:cell upData:self.dataSource[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark-loadData
- (void)event_listCell:(id<PublicListViewModelDelegate>)cell upData:(id)data
{
    NSAssert([cell conformsToProtocol:@protocol(PublicListViewModelDelegate)], @"cell 必须遵循PublicListViewModelDelegate协议");
    NSAssert([cell respondsToSelector:@selector(updata_setObject:)], @"cell 必须实现PublicListViewModelDelegate协议的代理方法");
    [cell updata_setObject:data];
}

#pragma mark-refresh
-(void)refresh_header
{
    self.page_current = 1;
    [self refresh_load];
}

- (void)refresh_footer
{
    self.page_current ++;
    [self refresh_load];
}

- (void)refresh_load
{
    
}

#pragma mark-lazyload
- (NSMutableArray<NSDictionary *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end
