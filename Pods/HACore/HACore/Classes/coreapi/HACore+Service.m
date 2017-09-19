//
//  HACore+Service.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+Service.h"
#import "HACoreHeader.h"
#import "HACoreAPI.h"

@implementation HACore (Service)

- (void)serviceRequestNewsWithPaging:(BOOL)isPaging
							 success:(void (^)(NSArray *))success
							   error:(void (^)(NSInteger, NSString *, id))apierror
							 failure:(void (^)(NSError *))failure {
	
	if (![[HAApp current] isLoggedIn]) {
		// NOT LOGGED IN
		
		apierror(-1, @"USER NOT LOGIN", nil);
		return;
	}
	
	NSDictionary *param;
	
	// FOR NOW, WE ARE LOCKING PAGING FEATURE
	isPaging = NO;
	
	if (!isPaging) {
		// RELOAD
		param = @{
				  @"atoken":[[HAApp current] atoken],
				  @"type":@0,
				  };
	} else {
		// NEXT PAGE
		param = @{
				  @"atoken":[[HAApp current] atoken],
				  @"type":@0,
				  };
	}
	
	[[HACoreAPI core] GETURLString:URL_SERVICE_NEWS withParameters:param success:^(id ret) {
		if (ret == nil || ![ret hasObjectWithKey:@"contents"] || [ret[@"contents"] count] == 0) {
			// EMPTY DATA
			success(nil);
		} else {
			NSMutableArray *result = [NSMutableArray arrayWithCapacity:1];
			
			for (NSDictionary *one in ret[@"contents"]) {
				[result addObject:@{
									HA_ICON:one[@"summaryImg"],
									HA_TITLE:[NSString stringWithFormat:@"%@", one[@"title"]],
									HA_SUBTITLE:@"",
									HA_CONTENT:[NSString stringWithFormat:@"%@", one[@"summary"]],
									HA_DATETIME:[[NSDate dateWithTimeIntervalSince1970:[one[@"createtime"] doubleValue]] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI],
									}];
			}
			
			success([NSArray arrayWithArray:result]);
			
			[result removeAllObjects];
			result = nil;
		}
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

@end
