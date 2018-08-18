//
//  PublicListViewModelDelegate.h
//  ExampleProjectDemo
//
//  Created by BlanBok on 2018/1/15.
//  Copyright © 2018年 juyuanGroup. All rights reserved.
//
/*
 创建人：OComme
 架构层级：协议
 功能描述：加载到“PublicListViewModel”上的cell必须遵循的代理方法
 所处位置：
 创建版本：V 1.0.0
 --修改人：
 修改版本：
 修改描述：
 */
#import <Foundation/Foundation.h>

@protocol PublicListViewModelDelegate <NSObject>

/**
 导入数据模型
 
 @param object 数据模型
 */
- (void)updata_setObject:(id _Nonnull)object;


@end
