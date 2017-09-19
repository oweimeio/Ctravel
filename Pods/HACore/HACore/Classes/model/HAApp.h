//
//  HAApp.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>
#import <HACore/HAModel.h>
#import <HACore/HACoreConst.h>

@class HAUserYg;
@class HAUserWjw;
@class HAUserPaxy;

/**
 华奥科技 核心库 模型 HAApp
 记录当前运行的App实例相关数据
 */
@interface HAApp : HAModel

/**
 获取当前应用实例. 此实例应为应用内唯一.

 @return 当前应用实例
 */
+ (instancetype)current;

/**
 当前应用用户登录状态. 
 
 YES为已登录, NO为未登录.
 */
@property (nonatomic, assign) BOOL isLoggedIn;

/**
 当前登录的用户的UID.
 若无登录用户，则返回空.
 */
@property (nonatomic, strong) NSString *userID;

/**
 用户登录的ATOKEN字符串.
 若无登录用户，则返回空.
 */
@property (nonatomic, strong) NSString *atoken;

/**
 验证码的发送状态数据.
 若无验证码信息，则返回空
 */
@property (nonatomic, strong) NSDictionary *verifyCode;

/**
 个推SDK产生的CID
 若无登录用户，或未注册成功个推SDK，则返回空
 */
@property (nonatomic, strong) NSString *getuiID;

/**
 iOS设备产生的Device Token
 */
@property (nonatomic, strong) NSString *deviceToken;

/**
 上次登录的用户名
 */
@property (nonatomic, strong) NSString *lastLogin;

/**
 消息未读数
 */
@property (nonatomic, assign) NSInteger badgeMessage;

/**
 消息未读数据展示
 */
@property (nonatomic, weak) NSString *badge;

/**
 应用程序类型
 */
@property (nonatomic, assign) AppType appType;

/**
 登录后更新持久化数据

 @param values 用户数据
 */
- (void)updateUserLoggedIn:(NSDictionary *)values;

/**
 登录微警务标准版以后持久化数据

 @param values 登录响应数据
 */
- (void)updateUserWjwLoggedIn:(NSDictionary *)values;

/**
 自更新微警务标准版用户持久化数据
 收取NOTIF_USER_UPDATED通知 标志着更新成功
 */
- (void)updateUserWjw;

/**
 获取当前登录的微警务标准版用户
 
 @return 微警务标准版用户模型实例
 */
- (HAUserWjw *)wjwUser;

/**
 登录阳光微警务后 持久化数据

 @param values 登录响应数据
 */
- (void)updateUserYgwjwLoggedIn:(NSDictionary *)values;

/**
 自更新阳光微警务用户持久化数据
 请收取NOTIF_USER_UPDATED通知 标志着更新成功
 */
- (void)updateUserYgwjw;

/**
 自更新帮扶直通车用户持久化数据
 请收取NOTIF_USER_UPDATED通知 标志着更新成功
 */
- (void)updateUserBfztc;

/**
 获取当前登录的阳光微警务用户

 @return 阳光微警务用户模型实例
 */
- (HAUserYg *)ygUser;

/**
 登录平安校园后 持久化数据

 @param values 登录响应数据
 */
- (void)updateUserPaxyLoggedIn:(NSDictionary *)values;

/**
 自动更新平安校园用户持久化数据
 请收取NOTIF_USER_UPDATED通知 标志着更新成功
 */
- (void)updateUserPaxy;

/**
 获取当前登录的平安校园用户

 @return 平安校园用户模型实例
 */
- (HAUserPaxy *)paxyUser;

/**
 注销
 */
- (void)logout;

@end
