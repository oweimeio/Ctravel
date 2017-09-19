//
//  HAUserPaxy.h
//  Pods
//
//  Created by FengkunMei on 2017/5/3.
//
//

#import <HACore/HACore.h>
#import <HACore/HAModel.h>
#import <HACore/HACoreConst.h>

/**
 用户在线状态

 - HAPaxyOnlineStatusIsLeave: 不在线
 - HAPaxyOnlineStatusIsOnline: 在线
 */
typedef NS_ENUM (NSInteger, HAPaxyOnlineStatus) {
	HAPaxyOnlineStatusIsLeave = 0,
	HAPaxyOnlineStatusIsOnline = 1,
};

/**
 平安校园用户模型
 */
@interface HAUserPaxy : HAModel <NSCopying, NSCoding>

/**
 手机号
 */
@property (nonatomic, strong) NSString *mobile;

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
 辖区坐标序列
 */
@property (nonatomic, strong) NSArray *deptArea;

/**
 辖区中心坐标
 */
@property (nonatomic, assign) CLLocationCoordinate2D deptCenter;

/**
 云图ID
 */
@property (nonatomic, strong) NSString *yuntuID;

/**
 云图Key
 */
@property (nonatomic, strong) NSString *yuntuKey;

/**
 云图TableID
 */
@property (nonatomic, strong) NSString *yuntuTableID;

/**
 用户在线状态
 */
@property (nonatomic, assign) HAPaxyOnlineStatus onlineStatus;

/**
 角色ID
 */
@property (nonatomic, strong) NSString *roleID;

/**
 角色名称
 */
@property (nonatomic, strong) NSString *roleName;

/**
 完整的用户数据JSON序列
 */
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 用户类型
 */

+ (instancetype)userWithUID:(NSString *)theUID;

@end
