//
//  HACore.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-04.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LYCategory/LYCategory.h>

FOUNDATION_EXPORT NSString *const LIB_HACONF_BUNDLE_ID;

@class HAUserWjw;

/**
 华奥科技 核心库
 */
@interface HACore : NSObject

// MARK: - INIT

/**
 核心库单例

 @return 单例
 */
+ (instancetype)core;

/**
 DEBUG模式开关
 */
@property (nonatomic, assign) BOOL debug;

// MARK: - CONF

/**
 系统配置文件

 @return 配置数据
 */
- (NSDictionary *)conf;

/**
 获取指定key的数据

 @param keys 数据键名
 @return 数据值
 */
- (id)valueForConfWithKey:(NSString *)keys;

// MARK: - TOOL

/**
 输出核心库控制台错误日志

 @param format 格式化字符串
 @return 核心库错误日志(带有时间戳)
 */
- (NSString *)logInnerError:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 输出核心库控制台警告日志

 @param format 格式化字符串
 @return 核心库警告日志(带有时间戳)
 */
- (NSString *)logInnerWarning:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2);

@end
