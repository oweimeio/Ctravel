//
//  HACore+Police.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>
#import <CoreLocation/CoreLocation.h>
#import <HACore/HACoreHeader.h>
/**
 华奥核心库 警情 模块
 */
@interface HACore (Police)



/**
 警情添加请求

 @param description 报警内容
 @param alertID 报警ID
 @param images 图片地址,多个图片逗号分隔
 @param voices 音频地址,多个音频逗号分隔
 @param voicesTime 音频时间长度,单位秒,多个逗号分隔
 @param videos 视频地址,多个逗号分隔
 @param videosTime 视频时间长度,单位秒,多个逗号分隔
 @param type 警情类型 1,一键报警 2,随手记 3,随手拍 (必传)
 @param address 报警地址 (必传)
 @param location 经纬度 (必传)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
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
								failure:(void (^)(NSError *error))failure;


/***************************************************************************************************/

/**
 一键报警 创建 网络请求
 
 @param coordinate 报警GPS坐标
 @param address 报警地址字符串
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeAlertCreateWithLocation:(CLLocationCoordinate2D)coordinate
						   andAddress:(NSString *)address
							  success:(void (^)(id ret))success
								error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							  failure:(void (^)(NSError *error))failure;

/**
 一键报警 更新警情 网络请求
 
 @param alertID 警情ID
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeAlertUpdateWithAlertID:(NSString *)alertID
							 success:(void (^)(id ret))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure;


/**
 警情协作(上报、委派、协作)请求

 @param alertID 举报记录id
 @param status 0为委派,1为上报,2为协作
 @param uids 协作的用户(多个以,为分隔符)
 @param content 说明备注
 @param images 图片内容(多个以,为分隔符)
 @param voices 语音(多个以,为分隔符)
 @param videos 视频(多个以,为分隔符)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeSaveAuditRecordWithAlertID:(NSString *)alertID
									   status:(int)status
										 uids:(NSString *)uids
									  content:(NSString *)content
									   images:(NSString *)images
									   voices:(NSString *)voices
									   videos:(NSString *)videos
									  success:(void (^)(id ret))success
							            error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									  failure:(void (^)(NSError *error))failure;


/**
 追加警情请求

 @param alertID 警情id
 @param result 处理结果
 @param type 类型
 @param status 状态
 @param resultvoices 声音(非必传)
 @param resultimgs 图片(非必传)
 @param resultvideos 视频(非必传)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeAppendalertWithAlertID:(NSString *)alertID
							  result:(NSString *)result
								type:(NSInteger)type
							  status:(NSInteger)status
						resultvoices:(NSString *)resultvoices
						  resultimgs:(NSString *)resultimgs
						resultvideos:(NSString *)resultvideos
							 success:(void (^)(id ret))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure;


/**
 警情处理请求

 @param alertID 警情id
 @param result 处理结果
 @param type 类型
 @param status 状态
 @param points 奖励积分
 @param resultvoices 声音(非必传)
 @param resultimgs 图片(非必传)
 @param resultvideos 视频(非必传)
 @param resultstatus 警情状态
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
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
						 failure:(void (^)(NSError *error))failure;


/**
 获取上报单位及人员列表

 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeGetReportListSuccess:(void (^)(id ret))success
							 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						   failure:(void (^)(NSError *error))failure;


/**
 评论警情请求

 @param alertID 警情id
 @param speed 处理速度的评论分数
 @param attitude 处理满意度的分数
 @param satisfied 总体满意度的分数
 @param explaintext 评论内容
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeSaveCommentsInfoWithAlertID:(NSString *)alertID
									speed:(NSString *)speed
								 attitude:(NSString *)attitude
								 satisfied:(NSString *)satisfied
							   explaintext:(NSString *)explaintext
								   success:(void (^)(id ret))success
						             error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								   failure:(void (^)(NSError *error))failure;


/**
 获取评论警情

 @param alertID 警情id
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeFindCommentsInfoToAlertID:(NSString *)alertID
								success:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure;


/**
 警情列表请求

 @param status 状态
 @param pageSize 每页个数
 @param pageIndex 页数
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)policeAlertListWithStatus:(NSInteger)status
						 pageSize:(NSInteger)pageSize
						pageIndex:(NSInteger)pageIndex
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure;


@end
