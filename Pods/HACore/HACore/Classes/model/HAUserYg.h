//
//  HAUserYg.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-18.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//


#import <HACore/HAModel.h>
#import <HACore/HACoreConst.h>

typedef NS_ENUM(NSInteger, HACoreYgIDAuthStatus) {
	HACoreYgIDAuthStatusNot = 1,		// 未认证
	HACoreYgIDAuthStatusOngoing = 2,	// 资料审核中
	HACoreYgIDAuthStatusPassed = 3,		// 已认证
	HACoreYgIDAuthStatusRejected = 4,		// 认证失败
};

typedef NS_ENUM(NSInteger, HACoreYgUserType) {
	HACoreYgUserTypeResident = 1,
	HACoreYgUserTypePolice = 2,
	HACoreYgUserTypeCadre = 3,
	HACoreYgUserTypeGridMember = 4,
	HACoreYgUserTypeDoctor = 5,
	HACoreYgUserTypeCommunityDocter = 6,
};

@interface HAUserYg : HAModel <NSCopying, NSCoding>

// UID - DEFAULT

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 头像
 */
@property (nonatomic, strong) NSString *avatar;

/**
 性别
 */
@property (nonatomic, assign) UserGender gender;

/**
 手机号
 */
@property (nonatomic, strong) NSString *mobile;

/**
 社区ID
 */
@property (nonatomic, assign) NSInteger communityID;

/**
 DEPT ID
 */
@property (nonatomic, strong) NSString *deptID;

/**
 云图KEY
 */
@property (nonatomic, strong) NSString *yuntuKey;

/**
 云图Table ID
 */
@property (nonatomic, strong) NSString *yuntuTableID;

/**
 云图 ID
 */
@property (nonatomic, strong) NSString *yuntuID;

/**
 实名认证状态
 */
@property (nonatomic, assign) HACoreYgIDAuthStatus authStatus;

/**
 生日
 */
@property (nonatomic, strong) NSDate *birthday;

/**
 地址
 */
@property (nonatomic, strong) NSString *address;

/**
 职位
 */
@property (nonatomic, strong) NSString *jobTitle;

/**
 警号/职工号
 */
@property (nonatomic, strong) NSString *jobNumber;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *IDNumber;

/**
 身份证正面照
 */
@property (nonatomic, strong) NSString *IDCardFront;

/**
 身份证反面照
 */
@property (nonatomic, strong) NSString *IDCardBack;

/**
 积分
 */
@property (nonatomic, assign) NSInteger point;

/**
 区域
 */
@property (nonatomic, strong) NSString *area;

/**
 用户类型ID
 */
@property (nonatomic, strong) NSString *userTypeID;

/**
 用户身份ID
 */
@property (nonatomic, strong) NSString *userIdentityID;

/**
 用户类型名称
 */
@property (nonatomic, strong) NSString *userTypeName;

/**
 单位类型
 */
@property (nonatomic, strong) NSString *unitName;

/**
 用户类型
 */
@property (nonatomic, assign) HACoreYgUserType type;

/**
 用户子类型
 */
@property (nonatomic, assign) NSInteger userIdentity;

/**
 服务器返回用户数据
 */
@property (nonatomic, strong) NSDictionary *userInfo;

//警务类型

//身份类型

+ (instancetype)userWithUID:(NSString *)theUID;

@end
