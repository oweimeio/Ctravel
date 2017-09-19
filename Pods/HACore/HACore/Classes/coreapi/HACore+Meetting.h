//
//  HACore+Meetting.h
//  CORE
//
//  CREATED BY FENGKUNMEI ON 2017-02-20.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>

@interface HACore (Meetting)

// MARK: Meetting

/**
 会议室列表请求
 
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)meettingListSuccess:(void (^)(id ret))success
					  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					failure:(void (^)(NSError *error))failure;


/**
 个人对个人视频互联

 @param RoomID 房间ID
 @param inviteID 接受邀请的用户ID
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)meettingPersonToPersonWithRoomID:(NSString *)RoomID
								inviteID:(NSString *)inviteID
								 success:(void (^)(id ret))success
								   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								 failure:(void (^)(NSError *error))failure;

/**
 创建会议室请求

 @param uids  参会人员uid
 @param mid 	房间id
 @param name 	app通知消息的内容
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)meettingCreateWithUids:(NSString *)uids
						   mid:(NSString *)mid
						  name:(NSString *)name
					   success:(void (^)(id ret))success
						 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					   failure:(void (^)(NSError *error))failure;


/**
 会议邀请请求

 @param roomId 	房间ID
 @param roomName 	会议室类型
 @param roomstr 	会议室房间编号
 @param inviter 	发起人名称
 @param topic 	会议主题
 @param time 发起时间，时间戳格式
 @param passsword 	会议房间密码
 @param uids 参会人员uid
 @param message app通知消息的内容
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)meettingInviteWithRoomID:(NSInteger)roomId
						roomName:(NSString *)roomName
					   roomidStr:(NSString *)roomstr
						 inviter:(NSString *)inviter
						   topic:(NSString *)topic
							time:(NSInteger)time
						passWord:(NSString *)passsword
							uids:(NSString *)uids
						 message:(NSString *)message
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure;

@end
