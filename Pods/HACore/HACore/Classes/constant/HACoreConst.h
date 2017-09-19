//
//  HACoreConst.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>

/**
 应用类型

 - AppTypeLogin: 需要登录
 - AppTypeResident: 居民端
 - AppTypePolice: 警用端
 */
typedef NS_ENUM(NSUInteger, AppType) {
	AppTypeLogin = 0,
	AppTypeResident = 1,
	AppTypePolice = 2,
};


/**
 警情类型
 
 - AlertTypePoice: 一键报警
 - AlertTypeNote: 随手记
 - AlertTypeReport: 随手拍
 - AlertTypeAdditional: 补录
 */
typedef NS_ENUM(NSInteger, AlertType) {
	AlertTypePoice = 1,
	AlertTypeNote = 2,
	AlertTypeReport = 3,
	AlertTypeAdditional = 4,
};


/**
 验证码类型

 - HAVerificationCodeTypeRegister: 注册验证码
 - HAVerificationCodeTypeResetPassword: 忘记密码验证码
 */
typedef NS_ENUM(NSInteger, HAVerificationCodeType) {
	HAVerificationCodeTypeRegister = 1,
	HAVerificationCodeTypeResetPassword = 2,
};

/**
 用户性别
 
 - UserGenderFemale: 女性
 - UserGenderMale: 男性
 - UserGenderNone: 未填写
 */
typedef NS_ENUM(NSUInteger, UserGender) {
	UserGenderFemale = 0,
	UserGenderMale = 1,
	UserGenderNone = 10,
};

/**
 实名认证状态

 - HAIDAuthStatusNot: 未认证
 - HAIDAuthStatusOngoing: 认证中
 - HAIDAuthStatusPassed: 已认证
 - HAIDAuthStatusRejected: 认证失败
 */
typedef NS_ENUM(NSInteger, HAIDAuthStatus) {
	HAIDAuthStatusNot = 0,
	HAIDAuthStatusOngoing = 1,
	HAIDAuthStatusPassed = 2,
	HAIDAuthStatusRejected = 4,
};

/**
 用户类型

 - HAUserTypeSuper: 超级管理员
 - HAUserTypeAdmin: 管理员
 - HAUserTypeOperator: 后台用户(服务人员)
 - HAUserTypeResident: 前台用户(居民)
 */
typedef NS_ENUM(NSInteger, HAUserType) {
	HAUserTypeSuper = 100,
	HAUserTypeAdmin = 80,
	HAUserTypeOperator = 10,
	HAUserTypeResident = 0,
};

FOUNDATION_EXPORT NSString *const SHANGHAI;

FOUNDATION_EXPORT NSString *const HAT_USERNAME;
FOUNDATION_EXPORT NSString *const HAT_PASSWORD;
FOUNDATION_EXPORT NSString *const HAT_APP_TYPE;


