//
//  HAUserWjw.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-01.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>
#import <HACore/HAModel.h>
#import <HACore/HACoreConst.h>
#import <CoreLocation/CoreLocation.h>

/**
 微警务用户模型
 */
@interface HAUserWjw : HAModel <NSCopying, NSCoding>

/**
 手机号
 */
@property (nonatomic, strong) NSString *mobile;

/**
 用户名(Server备注"无")
 */
@property (nonatomic, strong) NSString *username;

/**
 用户头像
 */
@property (nonatomic, strong) NSString *avatar;

/**
 用户性别
 */
@property (nonatomic, assign) UserGender gender;

/**
 用户生日
 */
@property (nonatomic, strong) NSDate *birthday;

/**
 用户真实姓名
 */
@property (nonatomic, strong) NSString *realname;

/**
 用户年龄
 */
@property (nonatomic, assign) NSUInteger age;

/**
 用户身份证号码
 */
@property (nonatomic, strong) NSString *IDNumber;

/**
 实名认证状态
 */
@property (nonatomic, assign) HAIDAuthStatus authStatus;

/**
 用户类型
 */
@property (nonatomic, assign) HAUserType userType;

/**
 判断是否有访问警务端功能的权限

 @return 是与否
 */
- (BOOL)hasOperationPrivilege;

/**
 辖区坐标序列
 */
@property (nonatomic, strong) NSArray *deptArea;

/**
 辖区中心坐标
 */
@property (nonatomic, assign) CLLocationCoordinate2D deptCenter;

/**
 云图Key
 */
@property (nonatomic, strong) NSString *yuntuKey;

/**
 云图TableID
 */
@property (nonatomic, strong) NSString *yuntuTableID;

/**
 完整的用户数据JSON序列
 */
@property (nonatomic, strong) NSDictionary *userInfo;


+ (instancetype)userWithUID:(NSString *)theUID;


@end
