//
//  HAPageViewController.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-19.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>
#import <HACore/HAViewController.h>

@interface HAPageViewController : HAViewController

/**
 设计初始化入口, 请仅使用该入口初始化本类.

 @param title 视图标题
 @param URLString 页面载入地址
 @param contentString 页面内容字符串
 @return 视图实例
 */
- (instancetype)initWithTitle:(NSString *)title andURLString:(NSString *)URLString orContent:(NSString *)contentString;

@end
