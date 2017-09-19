//
//  HAUser.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <HACore/HAModel.h>
#import <HACore/HACoreConst.h>


/**
 用户模型
 */
@interface HAUser : HAModel <NSCopying, NSCoding>

/**
 User name 用户姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 user gender 用户性别
 */
@property (nonatomic, assign) UserGender gender;

/**
 user identity number 用户身份证号
 */
@property (nonatomic, strong) NSString *IDNumer;

/**
 user mobile number 用户手机号码
 */
@property (nonatomic, strong) NSString *mobile;

/**
 user avatar URL 用户头像URL连接字符串
 */
@property (nonatomic, strong) NSString *avatar;

/**
 根据UID获取用户

 @param theUID 需要获取用户的UID
 @return 用户实例
 */
+ (instancetype)userWithUID:(NSString *)theUID;

@end
