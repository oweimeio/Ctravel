//
//  HACore+More.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-08.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+More.h"
#import "HACoreHeader.h"
#import "HACoreAPI.h"

@implementation HACore (More)

+ (NSArray *)moreMenuDatasource {
	
	// LOGIN
	// USER
	// DATA
	
	// CHECK LOGIN STATUS
	if (![[HAApp current] isLoggedIn]) {
		return nil;
	}
	
	HAUser *currentGuy = [HAUser userWithUID:[HAApp current].userID];
	
	NSMutableArray *menu = [NSMutableArray arrayWithCapacity:1];
	
	[menu addObject:@{
					  HA_ICON:currentGuy.avatar,
					  HA_TITLE:currentGuy.name,
					  HA_SUBTITLE:@(currentGuy.gender),
					  }];
	
	// PROFILE
	[menu addObject:@{
					  HA_ICON:@"ico-more-menu-profile",
					  HA_TITLE:@"我的资料",
					  }];
	
	// ID-VERIFY
	[menu addObject:@{
					  HA_ICON:@"ico-more-menu-id-verify",
					  HA_TITLE:@"实名认证",
					  }];
	
	if (!currentGuy) {
		[menu addObject:@{
						  HA_ICON:@"ico-more-menu-police-record",
						  HA_TITLE:@"报警记录",
						  }];
		
		[menu addObject:@{
						  HA_ICON:@"ico-more-menu-msg-board",
						  HA_TITLE:@"留言板",
						  }];
	} else if (currentGuy != nil) {
		[menu addObject:@{
						  HA_ICON:@"ico-more-menu-notebook",
						  HA_TITLE:@"随手记",
						  }];
	}
	
	
	// SETTINGS
	[menu addObject:@{
					  HA_ICON:@"ico-more-menu-settings",
					  HA_TITLE:@"设置",
					  }];
	
	return [NSArray arrayWithArray:menu];
}

+ (NSArray *)moreMenuDatasourceWjw {
	
	// LOGIN
	// USER
	// DATA
	
	// CHECK LOGIN STATUS
	if (![[HAApp current] isLoggedIn]) {
		return nil;
	}
	
	HAUserWjw *currentGuy = [HAUserWjw userWithUID:[HAApp current].userID];
	
	NSMutableArray *menu = [NSMutableArray arrayWithCapacity:1];
	
	[menu addObject:@{HA_TITLE:HA_ARRAY_GROUP_TITLE, HA_SUB_ARRAY:@[
								@{
								  HA_TITLE:currentGuy.username,
								  HA_SUBTITLE:@1,
								  },
							  ]}];
	
	[menu addObject:@{HA_TITLE:HA_ARRAY_GROUP_TITLE, HA_SUB_ARRAY:@[
								// PROFILE
								@{
								  HA_ICON:@"ico-more-menu-profile",
								  HA_TITLE:@"我的资料",
								  },
								// ID-VERIFY
								@{
								  HA_ICON:@"ico-more-menu-valid",
								  HA_TITLE:@"实名认证",
								  },
							  ],}];
	
	
	[menu addObject:@{HA_TITLE:HA_ARRAY_GROUP_TITLE, HA_SUB_ARRAY:@[
								// EXIT
								@{
								  HA_ICON:@"ico-more-menu-exit",
								  HA_TITLE:@"注销",
								  },
							  ]}];
	
	return [NSArray arrayWithArray:menu];
}


// MARK: - Message 留言板

+ (void)moreSendMsgWithContent:(NSString *)content
					   success:(void (^)(id))success
						 error:(void (^)(NSInteger, NSString *, id))apierror
					   failure:(void (^)(NSError *))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"content":([content isEqualToString:@""] || content.length == 0) ? @"" : content,
							};
	[[HACoreAPI core] GETURLString:URL_MORE_SEND_MSG withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}

+ (void)moreListMsgWithStartDate:(NSDate *)startDate
						 endDate:(NSDate *)endDate
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	//TODO: 有待优化
	NSString *startDateStamp;
	NSString *endDateStamp;
	if (startDate == nil) {
		startDateStamp = @"";
	} else {
		startDateStamp = [NSString stringWithFormat:@"%ld",(long)[startDate timeIntervalSince1970]];
	}
	if (endDate == nil) {
		endDateStamp = @"";
	} else {
		endDateStamp = [NSString stringWithFormat:@"%ld",(long)[endDate timeIntervalSince1970]];
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"startTime":startDateStamp,
							@"endTime":endDateStamp,
							};
	
	[[HACoreAPI core] GETURLString:URL_MORE_LIST_MSG withParameters:param success:^(id ret) {
		
		//DATA
		NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:1];
		
		for (NSDictionary *dict in ret) {
			NSMutableDictionary *rec = [NSMutableDictionary dictionaryWithCapacity:1];
			[rec setObject:dict[@"id"] forKey:HA_ID];
			[rec setObject:dict[@"name"] forKey:HA_TITLE];
			[rec setObject:dict[@"img"] forKey:HA_AVATAR];
			[rec setObject:[NSDate dateWithTimeIntervalSince1970:[dict[@"time"] doubleValue]] forKey:HA_DATETIME];
			[rec setObject:dict[@"content"] forKey:HA_CONTENT];
			if ([dict[@"status"] integerValue] == 1) { //有回复
				[rec setObject:@{
								 HA_CONTENT:dict[@"replyContent"],
								 HA_AVATAR:dict[@"replyImg"],
								 HA_TITLE:dict[@"replyName"],
								 HA_DATETIME:[NSDate dateWithTimeIntervalSince1970:[dict[@"replyTime"] doubleValue]],
									 }
						forKey:HA_COMMENT];
			}
			[dataArray addObject:rec];
		}
		
		success(dataArray);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)moreReplyMsgWithContent:(NSString *)content
						  msgID:(NSInteger)msgID
						success:(void (^)(id))success
						  error:(void (^)(NSInteger, NSString *, id))apierror
						failure:(void (^)(NSError *))failure {

	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"msgid":@(msgID),
							@"content":content,
							};
	
	[[HACoreAPI core] GETURLString:URL_MORE_REPLY_MSG withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}


+ (void)moreDeleteMsgWithID:(NSInteger)msgID
					success:(void (^)(id))success
					  error:(void (^)(NSInteger, NSString *, id))apierror
					failure:(void (^)(NSError *))failure {

	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"msgid":@(msgID),
							};
	
	[[HACoreAPI core] GETURLString:URL_MORE_DELETE_MSG withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}

// MARK: - Message 验证相关

+ (BOOL)moreVerifySendMsgWithContent:(NSString *)content {
	
	if ([content isEqualToString:@""] || content.length == 0) {
		[[HACore core] logInnerError:@"%s\n 缺少Msg内容", __func__];
		return NO;
	}
	
	return YES;

}

+ (BOOL)moreVerifyListMsgWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {

	if (startDate == nil || endDate == nil) {
		[[HACore core] logInnerError:@"%s\n 缺少开始 或 结束时间", __func__];
		return NO;
	}
	
	if (startDate != nil && endDate != nil ) {
		NSInteger startInteger = [startDate timeIntervalSince1970];
		NSInteger endInteger = [endDate timeIntervalSince1970];
		if (endInteger >= startInteger) {
			return YES;
		} else {
			[[HACore core] logInnerError:@"%s\n 结束时间不能小于开始时间", __func__];
			return NO;
		}
	}
	
	return YES;
}

+ (BOOL)moreVerifyReplyMsgWithID:(NSInteger)msgID content:(NSString *)content {
	
	if ([content isEqualToString:@""] || content.length == 0) {
		[[HACore core] logInnerError:@"%s\n 缺少留言内容", __func__];
		return NO;
	}

	return YES;
	
}

@end
