//
//  HACore+More.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-08.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>

/**
 Module More
 */
@interface HACore (More)

/**
 更多模块, 菜单列表的数据源方法

 @return 菜单列表数据源
 */
+ (NSArray *)moreMenuDatasource;

/**
 更多模块(微警务标准版), 菜单列表的数据源方法
 
 @return 菜单列表数据源
 */
+ (NSArray *)moreMenuDatasourceWjw;


// MARK - Message 留言板


/**
 发布留言请求

 @param content 留言内容
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)moreSendMsgWithContent:(NSString *)content
					   success:(void (^)(id ret))success
						 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					   failure:(void (^)(NSError *error))failure;


/**
 获取留言列表请求

 @param startDate 开始时间 (非必传)
 @param endDate 结束时间 (非必传)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)moreListMsgWithStartDate:(NSDate *)startDate
						 endDate:(NSDate *)endDate
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure;



/**
 回复留言请求

 @param content 回复内容
 @param msgID 留言ID
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)moreReplyMsgWithContent:(NSString *)content
						  msgID:(NSInteger)msgID
						success:(void (^)(id ret))success
						  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						failure:(void (^)(NSError *error))failure;


/**
 屏蔽留言请求

 @param msgID 留言ID
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)moreDeleteMsgWithID:(NSInteger)msgID
					success:(void (^)(id ret))success
					  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					failure:(void (^)(NSError *error))failure;

// MARK: - Message 验证相关


/**
 发布留言验证

 @param content 内容
 @return 验证是否通过
 */
+ (BOOL)moreVerifySendMsgWithContent:(NSString *)content;


/**
 留言列表验证 (需传值时验证)

 @param startDate 开始时间
 @param endDate 结束时间 
 @return 验证是否通过
 */
+ (BOOL)moreVerifyListMsgWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;


/**
 回复留言请求验证

 @param msgID 留言ID
 @param content 内容
 @return 验证是否通过
 */
+ (BOOL)moreVerifyReplyMsgWithID:(NSInteger)msgID content:(NSString *)content;


@end
