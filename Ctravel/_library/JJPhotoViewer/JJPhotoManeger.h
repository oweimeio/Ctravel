//
//  JJPhotoManeger.h
//  test
//
//  Created by KimBox on 15/4/28.
//  Copyright (c) 2015年 KimBox. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JJMainScrollView.h"


@interface JJPhotoManeger : NSObject

+ (instancetype)maneger;

@property(nonatomic,weak)id<JJPhotoDelegate> delegate;

#pragma mark - 核心功能
//本地图片放大浏览
-(void)showLocalPhotoViewer:(NSArray *)imageViews selecView:(UIImageView *)selecView;

//放大浏览网络图片
-(void)showNetworkPhotoViewer:(NSArray *)imageViews urlStrArr:(NSArray *)urlStrArr selecView:(UIImageView *)selecView;

@end
