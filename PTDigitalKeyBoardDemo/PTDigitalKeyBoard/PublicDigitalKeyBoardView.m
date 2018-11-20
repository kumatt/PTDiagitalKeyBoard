//
//  PublicDigitalKeyBoardView.m
//  customKeyboard
//
//  Created by Mac on 2018/8/18.
//  Copyright © 2018年 Shenzhen LvPai Culture Communication Co., Ltd. All rights reserved.
//

#import "PublicDigitalKeyBoardView.h"
#import <Masonry.h>

#import "PublicListViewModel.h"
#import "PublicDigitalKeyBoardCell.h"

#import "UIImage+ColorImage.h"

/**
 右侧按钮占屏幕比例
 */
#define CUSTOM_KEYBOARD_SCREENRATIO 0.18

@interface PublicDigitalKeyBoardView ()<UICollectionViewDelegate>

/**
 数字集合
 */
@property (nonnull,nonatomic,strong) UICollectionView *collection_digital;

/**
 退格按钮
 */
@property (nonnull,nonatomic,strong) UIButton *button_delete;

/**
 确定按钮
 */
@property (nonnull,nonatomic,strong) UIButton *button_nextstep;

/**
 数字列表配置
 */
@property (nonnull,nonatomic,strong) PublicListViewModel *vm_digital;

@end

@implementation PublicDigitalKeyBoardView


- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.collection_digital.backgroundColor = backgroundColor;
}

#pragma mark-event
//横竖屏切换
- (void)event_changeRotate:(NSNotification*)noti {
    UICollectionViewFlowLayout *flow = (id)self.collection_digital.collectionViewLayout;
    flow.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width*(1 - CUSTOM_KEYBOARD_SCREENRATIO) - 3)/3.0, 49);

    [self.collection_digital reloadData];
}

// 加载数据
- (void)event_reloadDigitals
{
    NSMutableArray *diagitals = [NSMutableArray array];
    for (NSUInteger index = 0; index < 9; index ++) {
        [diagitals addObject:@(index)];
    }
    [diagitals addObjectsFromArray:@[@0,@50,@(-50)]];
    
    [self.vm_digital.dataSource removeAllObjects];
    [self.vm_digital.dataSource addObjectsFromArray:diagitals];
    [self.collection_digital reloadData];
}

//退格
- (void)event_delete
{
    if ([self.nextResponder conformsToProtocol:@protocol(UITextInput)] == NO) {
        return;
    }
    UIResponder <UITextInput>*firstResponse = (id)self.nextResponder;

    [firstResponse deleteBackward];
}

//确定
- (void)event_nextstep
{
    if ([self.nextResponder conformsToProtocol:@protocol(UITextInput)] == NO) {
        return;
    }
    UIResponder <UITextInput> *firstResponse = (id)self.nextResponder;

    [firstResponse resignFirstResponder];
}

// 添加字符串
- (void)event_addCharacter:(NSString *)string
{
    if ([self.nextResponder conformsToProtocol:@protocol(UITextInput)] == NO) {
        return;
    }
    UIResponder <UITextInput> *firstResponse = (id)self.nextResponder;

    UITextRange *range = firstResponse.selectedTextRange;
    if ([firstResponse respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)] && [firstResponse shouldChangeTextInRange:range replacementText:string] == NO) {
        return;
    }
    [firstResponse replaceRange:range withText:string];
}

#pragma mark-collectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [NSString stringWithFormat:@"%@",self.vm_digital.dataSource[indexPath.item]];
    [self event_addCharacter:string];
}

#pragma mark-init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    self.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    [self subView_add];
    [self subView_layout];
    [self subView_viewModel];
}

- (void)subView_add
{
    [self add_collectionViewDigital];
    [self add_deleteButton];
    [self add_nextstepButton];
}

- (void)subView_layout
{
    [self.collection_digital mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.right.equalTo(self.button_delete.mas_left).offset(-1);
        make.height.mas_equalTo(200);
    }];
    [self.button_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.equalTo(self.mas_width).multipliedBy(CUSTOM_KEYBOARD_SCREENRATIO);
        make.height.mas_equalTo(99);
    }];
    [self.button_nextstep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.width.equalTo(self.mas_width).multipliedBy(CUSTOM_KEYBOARD_SCREENRATIO);
        make.height.mas_equalTo(100);
    }];
}

- (void)subView_viewModel
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(event_changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    self.vm_digital.listView = self.collection_digital;
    self.collection_digital.delegate = self;
    [self event_reloadDigitals];
}

#pragma mark-subView add
- (void)add_collectionViewDigital
{
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    flow.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width*(1 - CUSTOM_KEYBOARD_SCREENRATIO) - 3)/3.0, 49);
    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = 1;
    
    _collection_digital = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [_collection_digital registerClass:[PublicDigitalKeyBoardCell class] forCellWithReuseIdentifier:PublicList_ReuseIdentifier];
    [self addSubview:_collection_digital];
}

- (void)add_deleteButton
{
    _button_delete = [UIButton buttonWithType:UIButtonTypeCustom];
    _button_delete.backgroundColor = UIColor.whiteColor;
    [_button_delete setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [_button_delete setTitle:@"退格" forState:UIControlStateNormal];
    [self addSubview:_button_delete];
    
    [_button_delete setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
    [_button_delete setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [_button_delete addTarget:self action:@selector(event_delete) forControlEvents:UIControlEventTouchUpInside];
    [_button_delete addTarget:self action:@selector(event_delete) forControlEvents:UIControlEventTouchDownRepeat];
}

- (void)add_nextstepButton
{
    _button_nextstep = [UIButton buttonWithType:UIButtonTypeCustom];
    _button_nextstep.backgroundColor = UIColor.redColor;
    [_button_nextstep setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_button_nextstep setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:_button_nextstep];
    [_button_nextstep addTarget:self action:@selector(event_nextstep) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark-lazyload
- (PublicListViewModel *)vm_digital
{
    if (_vm_digital == nil) {
        _vm_digital = [PublicListViewModel new];
    }
    return _vm_digital;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
