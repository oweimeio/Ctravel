//
//  Const.h
//  WJW2
//
//  CREATED BY LUO YU ON 2017-02-13.
//  COPYRIGHT © 2017 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>

/**
 应用类型
 
 - AppTypeLogin: 需要登录
 - AppTypeResident: 客户端
 - AppTypePolice: 服务端
 */
//typedef NS_ENUM(NSUInteger, AppType) {
//    AppTypeLogin = 0,
//    AppTypeClient = 1,
//    AppTypeServer = 2,
//};

FOUNDATION_EXPORT NSString *const LOGIN_LOGIN;
FOUNDATION_EXPORT NSString *const LOGIN_NOTLOGIN;
FOUNDATION_EXPORT NSString *const LOGIN_REFRESHPWD;
FOUNDATION_EXPORT NSString *const LOGIN_REFRESHPWD_VALIDATE;

FOUNDATION_EXPORT NSString *const REGISTER_REGISTER;
FOUNDATION_EXPORT NSString *const REGISTER_VALIDATE;

