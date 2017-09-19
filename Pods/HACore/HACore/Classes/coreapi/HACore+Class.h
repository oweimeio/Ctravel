//
//  HACore+Class.h
//  Core
//
//  Created by FengkunMei on 2017/2/20.
//
//

#import <HACore/HACore.h>

@interface HACore (Class)

// MARK: Class

/**
 微课堂列表请求

 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)classListWithSuccess:(void (^)(id ret))success
					   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					 failure:(void (^)(NSError *error))failure;


/**
 微课堂带类型的列表请求

 @param type 类型(要查找的类型)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)classListWithType:(NSInteger)type
				  success:(void (^)(id ret))success
					error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
				  failure:(void (^)(NSError *error))failure;


@end
