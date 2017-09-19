//
//  HACore+Business.h
//  CORE
//
//  Created by FengkunMei on 2017/2/16.
//
//

#import <HACore/HACore.h>

/**
 华奥核心库 网上办事 模块
 */
@interface HACore (Business)


/**
 无犯罪记录申请请求

 @param name 申请者的名字
 @param applyId 申请ID
 @param idCard 身份证号
 @param cellPhone 手机号
 @param address 户籍地址
 @param residence 居住地址
 @param dept 证明单位
 @param reason 申请理由
 @param image 证明单位图片
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessSaveCrimeApplyInfoWithName:(NSString *)name
								   applyID:(NSString *)applyId
									idCard:(NSString *)idCard
								 cellPhone:(NSString *)cellPhone
								   address:(NSString *)address
								 residence:(NSString *)residence
									  dept:(NSString *)dept
									reason:(NSString *)reason
									 image:(NSString *)image
								   success:(void (^)(id ret))success
									 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								   failure:(void (^)(NSError *error))failure;


/**
 申请id查询犯罪记录请求

 @param applyId 申请id
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessFindCommentsInfoWithApplyID:(NSString *)applyId
									success:(void (^)(id ret))success
									  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									failure:(void (^)(NSError *error))failure;


/**
 审批无犯罪记录申请
 
 @param applyId 申请id
 @param status 审批状态
 @param remark 审批的意见
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessReviewWithApplyID:(NSString *)applyId
						   status:(NSString *)status
						   remark:(NSString *)remark
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure;


/**
 警用端用户查询犯罪记录接口

 @param page 页数(默认为1)
 @param size 长度(默认为8)
 @param status 状态(-1 为查询所有状态的值)
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessFindCommentsInfoToDeptWithPage:(NSInteger)page
										  size:(NSInteger)size
										status:(NSInteger)status
									   success:(void (^)(id ret))success
										 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									   failure:(void (^)(NSError *error))failure;


/**
 政策阅读请求

 @param contentID 阅读文件id
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessReadLearnWithContentID:(NSInteger)contentID
							   success:(void (^)(id ret))success
								 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							   failure:(void (^)(NSError *error))failure;


/**
 查询政策阅读请求

 @param contentID 阅读文件id
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)businessFindReadLearnWithContentID:(NSInteger)contentID
								   success:(void (^)(id ret))success
									 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								   failure:(void (^)(NSError *error))failure;



// 用户查询犯罪记录 (待认证 接口用途)




@end


