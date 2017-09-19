//
//  NSString+HACore.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-14.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSString (HACore)

/**
 验证手机号码，正常号码，允许+*-

 @return 是否通过验证
 */
- (BOOL)validatePhoneNumber;

/**
 验证手机号码，纯数字情况

 @return 是否通过验证
 */
- (BOOL)validatePhoneNumberProject;

/**
 验证密码

 @return 是否通过验证
 */
- (BOOL)validatePassword;

/**
 验证华奥服务返回的字符串数据是否为一个坐标

 @return 是否通过验证
 */
- (BOOL)validateHALocation;

/**
 获取坐标点

 @return 坐标点
 */
- (CLLocationCoordinate2D)haCoordinate;

/**
 获取标准坐标点(内含转化火星坐标系操作)

 @return 坐标点
 */
- (CLLocationCoordinate2D)haStaticCoordinate;

@end
