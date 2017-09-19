//
//  HACore+Authorization.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-04.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>
#import <HACore/HACoreConst.h>

/**
 华奥核心库 访问鉴权 模块
 */
@interface HACore (Authorization)

// MARK: - LOGIN 登录


/**
 登录输入验证
 
 @param tfMobile 手机号输入文本框
 @param tfPassword 密码输入文本框
 @return 验证通过与否
 */
+ (BOOL)authVerifyLoginMobileField:(UITextField *)tfMobile andPasswordField:(UITextField *)tfPassword;

/**
 登录请求
 
 @param mobile 手机号
 @param password 密码
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authLoginWithMobile:(NSString *)mobile
				andPassword:(NSString *)password
					success:(void (^)(id ret))success
					  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					failure:(void (^)(NSError *error))failure;

// MARK: - APNS


/**
 更新iOS端的APNS的Device Token

 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authUpdateDeviceTokenSuccess:(void (^)(id ret))success
						error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					  failure:(void (^)(NSError *error))failure;

/**
 更新阳光微警务iOS端的APNS的Device Token

 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authUpdateYgwjwAPNSDeviceTokenSuccess:(void (^)(id ret))success
										error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
									  failure:(void (^)(NSError *error))failure;

// MARK: - REGISTER 注册


/**
 注册请求
 
 @param account 手机号
 @param vcode 验证码
 @param password 密码
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authRegisterWithAccount:(NSString *)account
					   passWord:(NSString *)password
						  vcode:(NSString *)vcode
						success:(void (^)(id ret))success
						  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						failure:(void (^)(NSError *error))failure;


/**
 注册获取验证码请求
 
 @param account  手机号
 @param codeType 验证码类型
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authRegisterGetVcodeWithAccount:(NSString *)account
							   codeType:(HAVerificationCodeType)codeType
								success:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure;


/**
 校验手机号是否存在
 
 @param phone 手机号
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authRegisterHasPhone:(NSString *)phone
					 success:(void (^)(id ret))success
					   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					 failure:(void (^)(NSError *error))failure;

/**
 注册验证码校验请求
 
 @param vcode    验证码
 @param account  手机号
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authRegisterExamineWithVcode:(NSString *)vcode
							 account:(NSString *)account
							 success:(void (^)(id ret))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure;


/**
 用户类型请求
 
 @param zonecode 城市编码
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authUserTypeWithZonecode:(NSString *)zonecode
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure;


/**
 地区区域列表请求
 
 @param parentID 上级区域ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetLevelDeptListWithParentID:(NSString *)parentID
								 success:(void (^)(id ret))success
								   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								 failure:(void (^)(NSError *error))failure;


/**
 地区区域信息请求
 
 @param findID 区域ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetAreaFindID:(NSString *)findID
				  success:(void (^)(id ret))success
					error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
				  failure:(void (^)(NSError *error))failure;


/**
 获取部门信息接口
 
 @param UserID 用户ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetDeptWithUserID:(NSString *)UserID
					  success:(void (^)(id ret))success
						error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					  failure:(void (^)(NSError *error))failure;


/**
 根据父级ID获取 部门列表
 
 @param parantID 父级ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetDeptListWithParentID:(NSString *)parantID
							success:(void (^)(id ret))success
							  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							failure:(void (^)(NSError *error))failure;


/**
 根据区域ID获取 部门列表
 
 @param areaID 区域ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetDeptListWithAreaID:(NSString *)areaID
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure;

/**
 获取部门列表
 
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetDeptListSuccess:(void (^)(id ret))success
						 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					   failure:(void (^)(NSError *error))failure;


/**
 根据部门ID获取 人员类型
 
 @param deptID 部门ID
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetUserTypeWithDeptID:(NSString *)deptID
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure;


/**
 获取部门类型
 
 @param success  请求成功块
 @param apierror 请求错误块
 @param failure  请求失败块
 */
+ (void)authGetDeptListTypeSuccess:(void (^)(id ret))success
							 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						   failure:(void (^)(NSError *error))failure;


/**
 用户信息更新
 
 @param email 邮箱
 @param avatar 头像
 @param policemancode 警官号
 @param imageUrlIDFront 身份证正面
 @param imageUrlIDBack 身份证反面
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authUpdataUserWithEmail:(NSString *)email
						  avatar:(NSString *)avatar
				   policemanCode:(NSString *)policemancode
				 imageUrlIDFront:(NSString *)imageUrlIDFront
				  imageUrlIDBack:(NSString *)imageUrlIDBack
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure;


/**
 获取用户ID
 
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authGetUidWithTokenSuccess:(void (^)(id ret))success
							 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						   failure:(void (^)(NSError *error))failure;


/**
 获取用户信息
 
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authGetUserInfoWithTokenSuccess:(void (^)(id ret))success
								 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							   failure:(void (^)(NSError *error))failure;


/**
 身份认证请求
 
 @param name 用户姓名
 @param imageURLFront 身份证正面URL(选填)
 @param imageURLBack 身份证反面URL(选填)
 @param useridentity 用户身份ID
 @param usertype 用户类型ID
 @param description 描述(选填)
 @param idcard 身份证号
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authVerificationWithName:(NSString *)name
				   imageURLFront:(NSString *)imageURLFront
					imageURLBack:(NSString *)imageURLBack
					userIdentity:(NSString *)useridentity
						userType:(NSString *)usertype
					 description:(NSString *)description
						  idCard:(NSString *)idcard
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure;


/**
 修改密码请求

 @param phone 手机号
 @param password 密码
 @param rawPassword 新密码
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authChangePasswordWithPhone:(NSString *)phone
						   password:(NSString *)password
						rawPassword:(NSString *)rawPassword
							success:(void (^)(id ret))success
							  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						    failure:(void (^)(NSError *error))failure;


// MARK: - FORGOT PASSWORD 忘记密码


/**
 忘记密码输入验证
 
 @param tfNew 新密码输入文本框
 @param tfConfirm 确认密码输入文本框
 @return 验证通过与否
 */
+ (BOOL)authVerifyForgotPasswordNew:(UITextField *)tfNew confirm:(UITextField *)tfConfirm;


/**
 忘记密码请求
 
 @param newpassword 新密码
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authForgotResetPassword:(NSString *)newpassword
						account:(NSString *)account
						  vcode:(NSString *)vcode
						success:(void (^)(id ret))success
						  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						failure:(void (^)(NSError *error))failure;


/**
 忘记密码验证码请求
 
 @param account 手机号
 @param success 请求成功块
 @param apierror 请求错误块
 @param failure 请求失败块
 */
+ (void)authForgotGetVcodeWithAccount:(NSString *)account
							  success:(void (^)(id ret))success
								error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							  failure:(void (^)(NSError *error))failure;

// MARK: - 验证相关


/**
 注册输入验证
 
 @param accountField 手机号
 @param vcode 验证码
 @param passWord  密码
 @param locationStr 地区
 @param userTypeStr 用户类型
 @return 验证是否通过
 */
+ (BOOL)authVerifyWithAccount:(UITextField *)accountField
						vcode:(UITextField *)vcode
					 passWord:(UITextField *)passWord
				  locationStr:(NSString *)locationStr
				  userTypeStr:(NSString *)userTypeStr;


/**
 获取验证码输入验证
 
 @param accountField 手机号
 @return 验证是否通过
 */
+ (BOOL)authVerifyGetVcodeWithAccount:(UITextField *)accountField;


/**
 验证码校验验证
 
 @param vcode 验证码
 @param accountField 手机号
 @return 验证是否通过
 */
+ (BOOL)authVerifyVcode:(UITextField *)vcode account:(UITextField *)accountField;


/**
 用户类型验证
 
 @param citycode 城市编码
 @return 验证是否通过
 */
+ (BOOL)authVerifyUserType:(NSString *)citycode;

@end
