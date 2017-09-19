//
//  HACore+Police.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+Police.h"
#import "HAConstHeader.h"
#import "HACoreData.h"
#import "HACoreAPI.h"
#import "HACoreHeader.h"

@implementation HACore (Police)


+ (void)policeCreatAlertWithDescription:(NSString *)description
								alertID:(NSString *)alertID
								 images:(NSString *)images
								 voices:(NSString *)voices
							 voicesTime:(NSString *)voicesTime
								 videos:(NSString *)videos
							 videosTime:(NSString *)videosTime
								   type:(AlertType)type
								address:(NSString *)address
							   location:(NSString *)location
								success:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure {
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"alertId":!alertID ? @"" : alertID,
							@"description":description,
							@"imgs":([images isEqualToString:@""] || images.length == 0) ? @"" : images,
							@"voices":([voices isEqualToString:@""] || voices.length == 0) ? @"" : voices,
							@"videos":([videos isEqualToString:@""] || videos.length == 0) ? @"" : videos,
							@"voicesTime":([voicesTime isEqualToString:@""] || voicesTime.length == 0) ? @"" : voicesTime,
							@"videosTime":([videosTime isEqualToString:@""] || videosTime.length == 0) ? @"" : videosTime,
							@"type":@(type),
							@"address":address,
							@"location":location,
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_ALERT_CREATE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

/***************************************************************************************************/

+ (void)policeAlertCreateWithLocation:(CLLocationCoordinate2D)coordinate
						   andAddress:(NSString *)address
							  success:(void (^)(id))success
								error:(void (^)(NSInteger, NSString *, id))apierror
							  failure:(void (^)(NSError *))failure {
	
	NSDictionary *param = @{
							
							};
	[[HACoreAPI core] GETURLString:URL_POLICE_ALERT_CREATE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)policeAlertUpdateWithAlertID:(NSString *)alertID
							 success:(void (^)(id))success
							   error:(void (^)(NSInteger, NSString *, id))apierror
							 failure:(void (^)(NSError *))failure {
	
	NSDictionary *param = @{
							
							};
	[[HACoreAPI core] GETURLString:URL_POLICE_ALERT_UPDATE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}


+ (void)policeSaveAuditRecordWithAlertID:(NSString *)alertID
								  status:(int)status
									uids:(NSString *)uids
								 content:(NSString *)content
								  images:(NSString *)images
								  voices:(NSString *)voices
								  videos:(NSString *)videos
								 success:(void (^)(id ret))success
								   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"aid":alertID,
							@"content":content,
							@"images":([images isEqualToString:@""] || images.length == 0) ? @"" : images,
							@"voices":([voices isEqualToString:@""] || voices.length == 0) ? @"" : voices,
							@"videos":([videos isEqualToString:@""] || videos.length == 0) ? @"" : videos,
							@"status":@(status),
							@"uids":([uids isEqualToString:@""] || uids.length == 0) ? @"" : uids,
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_APPOINTED withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)policeAppendalertWithAlertID:(NSString *)alertID
							  result:(NSString *)result
								type:(NSInteger)type
							  status:(NSInteger)status
						resultvoices:(NSString *)resultvoices
						  resultimgs:(NSString *)resultimgs
						resultvideos:(NSString *)resultvideos
							 success:(void (^)(id ret))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"alertid":alertID,
							@"result":result,
							@"type":@(type),
							@"status":@(status),
							@"resultvoices":([resultvoices isEqualToString:@""] || resultvoices.length == 0) ? @"" : resultvoices,
							@"resultimgs":([resultimgs isEqualToString:@""] || resultimgs.length == 0) ? @"" : resultimgs,
							@"resultvideos":([resultvideos isEqualToString:@""] || resultvideos.length == 0) ? @"" : resultvideos,
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_APPENDALERT withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}


+ (void)policeProcessWithAlertID:(NSString *)alertID
						  result:(NSString *)result
							type:(NSInteger)type
						  status:(NSInteger)status
						  points:(NSString *)points
					resultvoices:(NSString *)resultvoices
					  resultimgs:(NSString *)resultimgs
					resultvideos:(NSString *)resultvideos
					resultstatus:(NSInteger)resultstatus
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"alertid":alertID,
							@"result":result,
							@"type":@(type),
							@"status":@(status),
							@"points":([points isEqualToString:@""] || points.length == 0) ? @"" : points,
							@"resultvoices":([resultvoices isEqualToString:@""] || resultvoices.length == 0) ? @"" : resultvoices,
							@"resultimgs":([resultimgs isEqualToString:@""] || resultimgs.length == 0) ? @"" : resultimgs,
							@"resultvideos":([resultvideos isEqualToString:@""] || resultvideos.length == 0) ? @"" : resultvideos,
							@"resultstatus":@(resultstatus),
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_PROCESS withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
	
}


+ (void)policeGetReportListSuccess:(void (^)(id))success
							 error:(void (^)(NSInteger, NSString *, id))apierror
						   failure:(void (^)(NSError *))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	[[HACoreAPI core] GETURLString:URL_POLICE_GETREPORTLIST withParameters:@{@"atoken":[HAApp current].atoken,} success:^(id ret) {
		
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
	
}


+ (void)policeSaveCommentsInfoWithAlertID:(NSString *)alertID
									speed:(NSString *)speed
								 attitude:(NSString *)attitude
								satisfied:(NSString *)satisfied
							  explaintext:(NSString *)explaintext
								  success:(void (^)(id ret))success
									error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								  failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"alertid":alertID,
							@"speed":([speed isEqualToString:@""] || speed.length == 0) ? @"" : speed,
							@"attitude":([attitude isEqualToString:@""] || attitude.length == 0) ? @"" :attitude,
							@"satisfied":([satisfied isEqualToString:@""] || satisfied.length == 0) ? @"" :satisfied,
							@"explaintext":([explaintext isEqualToString:@""] || explaintext.length == 0) ? @"" :explaintext,
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_COMMENTS withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)policeFindCommentsInfoToAlertID:(NSString *)alertID
								success:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[HAApp current].atoken,
							@"alertid":alertID,
							};
	
	[[HACoreAPI core] GETURLString:URL_POLICE_FINDCOMMENTS withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)policeAlertListWithStatus:(NSInteger)status
						 pageSize:(NSInteger)pageSize
						pageIndex:(NSInteger)pageIndex
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure {
	
	if (0 == status || 1 == status || 2 == status) {
		
		if ([HAApp current].atoken == nil) {
			[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
			return;
		}
		
		NSDictionary *param = @{
								@"atoken":[HAApp current].atoken,
								@"status":@(status),
								@"pageSize":@(pageSize),
								@"pageIndex":@(pageIndex),
								};
		
		[[HACoreAPI core] GETURLString:URL_POLICE_ALERT_LIST withParameters:param success:^(id ret) {
			success(ret);
			
			// DATA
			NSMutableArray *results = [NSMutableArray arrayWithCapacity:pageSize];
			
			
			
			for (NSDictionary *record in ret) {
				
				NSMutableDictionary *rec = [NSMutableDictionary dictionaryWithCapacity:1];
				
				[rec setObject:record[@"id"] forKey:HA_ID];
				[rec setObject:record[@"reporterName"] forKey:HA_TITLE];
				[rec setObject:[NSString stringWithFormat:@"电话: %@", record[@"userinfo"][@"cellphone"]] forKey:HA_SUBTITLE];
				[rec setObject:record[@"userinfo"][@"icon"] forKey:HA_AVATAR];
				[rec setObject:[NSDate dateWithTimeIntervalSince1970:[record[@"createtime"] doubleValue]] forKey:HA_DATETIME];
				
				if ([record hasObjectWithKey:@"result"]) {
					[rec setObject:record[@"result"] forKey:HA_CONTENT];
				} else {
					[rec setObject:@"" forKey:HA_CONTENT];
				}
				
				if ([record hasObjectWithKey:@"imgs"] && [record[@"imgs"] count] > 0) {
					[rec setObject:record[@"imgs"] forKey:HA_IMAGES];
				} else {
					[rec setObject:@[] forKey:HA_IMAGES];
				}
				
				if ([record hasObjectWithKey:@"videos"] && [record[@"videos"] count] > 0) {
					[rec setObject:record[@"videos"] forKey:HA_VIDEOS];
				} else {
					[rec setObject:@[] forKey:HA_VIDEOS];
				}
				
				if ([record hasObjectWithKey:@"voices"] && [record[@"voices"] count] > 0) {
					[rec setObject:record[@"voices"] forKey:HA_VOICES];
				} else {
					[rec setObject:@[] forKey:HA_VOICES];
				}
				
				[results addObject:rec];
			}
			
			// ORDER DATASET
			
			// RETURN VALUE
			success([NSArray arrayWithArray:results]);
			
		} error:^(NSInteger code, NSString *msg, id ret) {
			apierror(code, msg, ret);
		} failure:^(NSError *error) {
			failure(error);
		}];
		
	} else {
		
		[[HACore core] logInnerError:@"status --> 状态值输入有误"];
		
	}
	
	
}


@end
