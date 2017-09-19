//
//  HACore+Class.m
//  Core
//
//  Created by FengkunMei on 2017/2/20.
//
//

#import "HACore+Class.h"
#import "HAConstHeader.h"
#import "HACoreData.h"
#import "HACoreAPI.h"
#import "HACoreHeader.h"

@implementation HACore (Class)

+ (void)classListWithSuccess:(void (^)(id ret))success
					   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n 原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							};
	
	[[HACoreAPI core] GETURLString:URL_CLASS_LIST withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)classListWithType:(NSInteger)type
				  success:(void (^)(id ret))success
					error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
				  failure:(void (^)(NSError *error))failure {

	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n 原因 --> 缺少atoken",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"type":@(type),
							};
	[[HACoreAPI core] GETURLString:URL_CLASS_LIST_TYPE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];

}

@end
