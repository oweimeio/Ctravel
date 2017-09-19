//
//  HACore+Meetting.m
//  CORE
//
//  CREATED BY FENGKUNMEI ON 2017-02-20.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+Meetting.h"
#import "HAConstHeader.h"
#import "HACoreData.h"
#import "HACoreAPI.h"
#import "HACoreHeader.h"

@implementation HACore (Meetting)


+ (void)meettingListSuccess:(void (^)(id ret))success
					  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					failure:(void (^)(NSError *error))failure {

	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s,原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[[HAApp current] atoken],
							};
	[[HACoreAPI core] POSTURLString:URL_MEETTING_LIST withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}

+ (void)meettingPersonToPersonWithRoomID:(NSString *)RoomID
								inviteID:(NSString *)inviteID
								 success:(void (^)(id ret))success
								   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								 failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s,原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"roomid":RoomID,
							@"toid":inviteID,
							};
	[[HACoreAPI core] POSTURLString:URL_MEETTING_P2P withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)meettingCreateWithUids:(NSString *)uids
						   mid:(NSString *)mid
						  name:(NSString *)name
					   success:(void (^)(id ret))success
						 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					   failure:(void (^)(NSError *error))failure {

	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s,原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"mid":mid,
							@"uids":uids,
							@"name":name,
							};
	[[HACoreAPI core]GETURLString:URL_MEETTING_CREAT withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}


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
						 failure:(void (^)(NSError *error))failure {

	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s,原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"inviter":inviter,
							@"topic":topic,
							@"time":@(time),
							@"roomid":@(roomId),
							@"roomname":roomName,
							@"password":passsword,
							@"uids":uids,
							@"message":message,
							@"roomidstr":roomstr,
							};
	[[HACoreAPI core]GETURLString:URL_MEETTING_INVITE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


@end
