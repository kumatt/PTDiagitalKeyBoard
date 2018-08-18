
//
//  PublicDigitalKeyBoardCell.m
//  customKeyboard
//
//  Created by Mac on 2018/8/18.
//  Copyright © 2018年 Shenzhen LvPai Culture Communication Co., Ltd. All rights reserved.
//

#import "PublicDigitalKeyBoardCell.h"
#import <Masonry.h>

@interface PublicDigitalKeyBoardCell ()

/**
 文本内容
 */
@property (nonnull,nonatomic,strong) UILabel *label_title;

@end

@implementation PublicDigitalKeyBoardCell

- (void)updata_setObject:(id)object
{
    self.label_title.text = [NSString stringWithFormat:@"%@",object];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted?[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]:UIColor.whiteColor;
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
    self.backgroundColor = UIColor.whiteColor;
    
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(0, 0));
    }];
}


#pragma mark-lazyload
- (UILabel *)label_title
{
    if (_label_title == nil) {
        _label_title = [UILabel new];
        _label_title.textColor = UIColor.blackColor;
        [self.contentView addSubview:_label_title];
        
    }
    return _label_title;
}


@end
