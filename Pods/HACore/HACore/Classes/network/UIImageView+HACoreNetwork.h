//
//  UIImageView+HACoreNetwork.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-02.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HACoreNetwork)

/**
 设置网络图片

 @param URLString 图片地址字符串
 @param imageName 占位图名称
 */
- (void)setImageWithURLString:(NSString *)URLString andPlaceholderNamed:(NSString *)imageName;

/**
 设置网络图片

 @param URLString 图片地址字符串
 @param imageName 占位图名称
 @param bundle 占位图bundle
 */
- (void)setImageWithURLString:(NSString *)URLString andPlaceholderNamed:(NSString *)imageName inBundle:(NSBundle *)bundle;

@end
