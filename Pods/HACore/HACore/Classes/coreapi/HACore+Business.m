//
//  HACore+Business.m
//  Pods
//
//  Created by FengkunMei on 2017/2/16.
//
//

#import "HACore+Business.h"
#import "HACoreHeader.h"
#import "HACoreAPI.h"

@implementation HACore (Business)

+ (void)businessSaveCrimeApplyInfoWithName:(NSString *)name
								   applyID:(NSString *)applyId
									idCard:(NSString *)idCard
								 cellPhone:(NSString *)cellPhone
								   address:(NSString *)address
								 residence:(NSString *)residence
									  dept:(NSString *)dept
									reason:(NSString *)reason
									 image:(NSString *)image
								   success:(void (^)(id))success
									 error:(void (^)(NSInteger, NSString *, id))apierror
								   failure:(void (^)(NSError *))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"applyid":applyId,
							@"name":name,
							@"idcard":idCard,
							@"cellphone":cellPhone,
							@"addr":address,
							@"residenceaddr":residence,
							@"dept":dept,
							@"reason":reason,
							@"image":image,
							};
	
	[[HACoreAPI core] GETURLString:URL_BUSINESS_CRIMEAPPLY withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)businessFindCommentsInfoWithApplyID:(NSString *)applyId
									success:(void (^)(id ret))success
									  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"applyid":applyId,
							};
	
	[[HACoreAPI core] GETURLString:URL_BUSINESS_TOAPPLYID withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}


+ (void)businessReviewWithApplyID:(NSString *)applyId
						   status:(NSString *)status
						   remark:(NSString *)remark
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"applyid":applyId,
							@"status":status,
							@"remark":remark,
							};
	
	[[HACoreAPI core] GETURLString:URL_BUSINESS_REVIEW withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)businessFindCommentsInfoToDeptWithPage:(NSInteger)page
										  size:(NSInteger)size
										status:(NSInteger)status
									   success:(void (^)(id ret))success
										 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									   failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	if (page <= 0) {
		page = 1;
	}
	
	if (size <= 0) {
		size = 8;
	}
	if (status == -1) {
		
		NSDictionary *param = @{
								@"atoken":[[HAApp current] atoken],
								@"page":@(page),
								@"size":@(size),
								};
		
		[[HACoreAPI core] GETURLString:URL_BUSINESS_DEPT withParameters:param success:^(id ret) {
			success(ret);
		} error:^(NSInteger code, NSString *msg, id ret) {
			apierror(code, msg, ret);
		} failure:^(NSError *error) {
			failure(error);
		}];
		
	} else {
		
		NSDictionary *param = @{
								@"atoken":[[HAApp current] atoken],
								@"page":@(page),
								@"status":@(status),
								@"size":@(size),
								};
		[[HACoreAPI core] GETURLString:URL_BUSINESS_DEPT withParameters:param success:^(id ret) {
			success(ret);
		} error:^(NSInteger code, NSString *msg, id ret) {
			apierror(code, msg, ret);
		} failure:^(NSError *error) {
			failure(error);
		}];
	}
	
}


+ (void)businessReadLearnWithContentID:(NSInteger)contentID
							   success:(void (^)(id ret))success
								 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							   failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"contentId":@(contentID),
							};
	[[HACoreAPI core] GETURLString:URL_BUSINESS_READ withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)businessFindReadLearnWithContentID:(NSInteger)contentID
								   success:(void (^)(id ret))success
									 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								   failure:(void (^)(NSError *error))failure {
	
	if ([[HAApp current] atoken] == nil) {
		[[HACore core] logInnerError:@"请求 --> %s \n,原因 --> 缺少atoken\n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"atoken":[[HAApp current] atoken],
							@"contentId":@(contentID),
							};

	[[HACoreAPI core] GETURLString:URL_BUSINESS_FIND_READ withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}


@end
