//
//  HACore+Service.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>

/**
 华奥核心库 微服务 模块
 */
@interface HACore (Service)

/**
 获取 微服务-社区热点 列表数据

 @param isPaging 是否分页请求
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
- (void)serviceRequestNewsWithPaging:(BOOL)isPaging
							 success:(void (^)(NSArray *news))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure;

@end
