//
//  HACore+Authorization.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-04.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+Authorization.h"
#import "HACoreAPI.h"
#import "UITextField+Core.h"
#import <FCUUID/UIDevice+FCUUID.h>
#import "HACoreHeader.h"

@implementation HACore (Authorization)

// MARK: - LOGIN

+ (BOOL)authVerifyLoginMobileField:(UITextField *)tfMobile andPasswordField:(UITextField *)tfPassword {
	
	if (tfMobile == nil || ![tfMobile isKindOfClass:[UITextField class]]) {
		[[HACore core] logInnerError:@"auth login mobile field nil"];
		return NO;
	}
	
	if (tfPassword == nil || ![tfPassword isKindOfClass:[UITextField class]]) {
		[[HACore core] logInnerError:@"auth login password field nil"];
		return NO;
	}
	
	NSInteger minlength = [(NSNumber *)[[HACore core] valueForConfWithKey:@"auth-login-pwd-min-length"] integerValue];
	NSInteger maxlength = [(NSNumber *)[[HACore core] valueForConfWithKey:@"auth-login-pwd-max-length"] integerValue];
	
	if ([[tfMobile.text trimSpace] isEqualToString:@""]) {
		[[HACore core] logInnerError:@"auth login mobile field empty"];
		return NO;
	}
	
	if (tfPassword.text.length < minlength) {
		[[HACore core] logInnerError:@"auth login password field less than min value"];
		return NO;
	} else if (tfPassword.text.length > maxlength) {
		[[HACore core] logInnerError:@"auth login password field larger than max value"];
		return NO;
	}
	
	return YES;
}

+ (void)authLoginWithMobile:(NSString *)mobile
				andPassword:(NSString *)password
					success:(void (^)(id))success
					  error:(void (^)(NSInteger, NSString *, id))apierror
					failure:(void (^)(NSError *))failure {
	
	if ([HAApp current].deviceToken == nil) {
		
		NSDictionary *param = @{
								@"phone":[mobile trimSpace],
								@"password":[password md5Uppercase32],
								@"deviceid":[[UIDevice currentDevice] uuid],
								@"gtCode":([HAApp current].getuiID != nil) ? [HAApp current].getuiID : @"",
								};
		
		[[HACoreAPI core] POSTURLString:URL_AUTH_LOGIN withParameters:param success:^(id ret) {
			
			// PERSIST USER
			// currentAPP -> user-me, atoken
			[[HAApp current] updateUserLoggedIn:ret[@"data"]];
			
			// -> UserType
			
			success(ret);
			
		} error:^(NSInteger code, NSString *msg, id ret) {
			apierror(code, msg, ret);
		} failure:^(NSError *error) {
			failure(error);
		}];
		
	} else {
		NSDictionary *param = @{
								@"phone":[mobile trimSpace],
								@"password":[password md5Uppercase32],
								@"deviceid":[[UIDevice currentDevice] uuid],
								@"deviceToken":[HAApp current].deviceToken,
								@"gtCode":([HAApp current].getuiID != nil) ? [HAApp current].getuiID : @"",
								};
		
		[[HACoreAPI core] POSTURLString:URL_AUTH_LOGIN withParameters:param success:^(id ret) {
			
			// PERSIST USER
			// currentAPP -> user-me, atoken
			[[HAApp current] updateUserWjwLoggedIn:ret[@"data"]];
			
			// -> UserType
			
			success(ret);
			
		} error:^(NSInteger code, NSString *msg, id ret) {
			apierror(code, msg, ret);
		} failure:^(NSError *error) {
			failure(error);
		}];
		
	}
	
}

+ (void)authUpdateDeviceTokenSuccess:(void (^)(id))success
							   error:(void (^)(NSInteger, NSString *, id))apierror
							 failure:(void (^)(NSError *))failure {
	
	if ([[HAApp current] isLoggedIn] == NO || [HAApp current].deviceToken == nil) {
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"id":[HAApp current].userID,
							@"deviceToken":[HAApp current].deviceToken,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_USER_UPDATE withParameters:param success:^(id ret) {
		if (success != nil) {
			success(ret);
		}
	} error:^(NSInteger code, NSString *msg, id ret) {
		if (apierror != nil) {
			apierror(code, msg, ret);
		}
	} failure:^(NSError *error) {
		if (failure != nil) {
			failure(error);
		}
	}];
}

+ (void)authUpdateYgwjwAPNSDeviceTokenSuccess:(void (^)(id))success error:(void (^)(NSInteger, NSString *, id))apierror failure:(void (^)(NSError *))failure {
	
	if ([[HAApp current] isLoggedIn] == NO || [HAApp current].getuiID == nil) {
		return;
	}
	
	NSDictionary *param = @{
							@"getui_cid":[HAApp current].getuiID,
							@"atoken":[HAApp current].atoken,
							};
	[[HACoreAPI core] POSTURLString:@"/user/update.action" withParameters:param success:^(id ret) {
		if (success != nil) {
			success(ret);
		}
	} error:^(NSInteger code, NSString *msg, id ret) {
		if (apierror != nil) {
			apierror(code, msg, ret);
		}
	} failure:^(NSError *error) {
		if (failure != nil) {
			failure(error);
		}
	}];
}

// MARK: - REGISTER


+ (void)authRegisterWithAccount:(NSString *)account
					   passWord:(NSString *)password
						  vcode:(NSString *)vcode
						success:(void (^)(id ret))success
						  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						failure:(void (^)(NSError *error))failure {
	
	NSDictionary *param = @{
							@"phone":account,
							@"password":[password md5Uppercase32],
							@"code":vcode,
							@"deviceID":[[UIDevice currentDevice] uuid],
							};
	
	[[HACoreAPI core] POSTURLString:URL_AUTH_REGISTER withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
	
}

+ (void)authRegisterGetVcodeWithAccount:(NSString *)account
							   codeType:(HAVerificationCodeType)codeType
								success:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure {
	
	NSString *codeStr;
	if (codeType == HAVerificationCodeTypeRegister) {
		codeStr = @"register";
	} else if (codeType == HAVerificationCodeTypeResetPassword) {
		codeStr = @"findPwd";
	}
	
	NSDictionary *param = @{
							@"phone":account,
							@"type":codeStr,
							};
	
	[[HACoreAPI core] POSTURLString:URL_AUTH_VERIFICATION_CODE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)authRegisterHasPhone:(NSString *)phone
					 success:(void (^)(id ret))success
					   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					 failure:(void (^)(NSError *error))failure {
	
	NSDictionary *param = @{
							@"phone":phone,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_HAS_PHONE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)authRegisterExamineWithVcode:(NSString *)vcode
							 account:(NSString *)account
							 success:(void (^)(id ret))success
							   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							 failure:(void (^)(NSError *error))failure {
	
	NSDictionary *param = @{
							@"account":account,
							@"deviceid":[[UIDevice currentDevice] uuid],
							@"vcode":vcode
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_REGISTER_CODE_VERIFY withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)authUserTypeWithZonecode:(NSString *)zonecode
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure {
	
	NSDictionary *param = @{
							@"zoneCode":zonecode,
							@"unitType":@(811),
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_USER_TYPE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)authGetLevelDeptListWithParentID:(NSString *)parentID
								 success:(void (^)(id ret))success
								   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								 failure:(void (^)(NSError *error))failure {

	NSDictionary *param;
	
	if ([HAApp current].atoken == nil) {
		param = @{@"parentId":parentID,};
	} else {
		param = @{
				  @"token":[HAApp current].atoken,
				  @"parentId":parentID,
				  };
	}
	
	[[HACoreAPI core] POSTURLString:URL_AUTH_ADDRESSES withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)authGetAreaFindID:(NSString *)findID
				  success:(void (^)(id ret))success
					error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
				  failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"id":findID,
							};
	
	[[HACoreAPI core] POSTURLString:URL_AUTH_AREA_FINDID withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)authGetDeptWithUserID:(NSString *)UserID
					  success:(void (^)(id ret))success
						error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					  failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"id":UserID,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_DEPT_INFO withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}


+ (void)authGetDeptListWithParentID:(NSString *)parantID
					  success:(void (^)(id ret))success
							  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					  failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"parentId":parantID,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_DEPT_LIST withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authGetDeptListWithAreaID:(NSString *)areaID
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"areaId":areaID,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_DEPT_LIST_AREA withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authGetDeptListSuccess:(void (^)(id ret))success
						 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
					   failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_DEPT_LIST withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authGetUserTypeWithDeptID:(NSString *)deptID
						  success:(void (^)(id ret))success
							error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						  failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							@"deptId":deptID,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_USERTYPR withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authGetDeptListTypeSuccess:(void (^)(id ret))success
							 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						   failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_DEPT_TYPE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
	
}

+ (void)authUpdataUserWithEmail:(NSString *)email
						 avatar:(NSString *)avatar
				  policemanCode:(NSString *)policemancode
				imageUrlIDFront:(NSString *)imageUrlIDFront
				 imageUrlIDBack:(NSString *)imageUrlIDBack
						success:(void (^)(id ret))success
						  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	if ([HAApp current].userID == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少userID \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"token":[[HAApp current] atoken],
							@"id":[[HAApp current] userID],
							@"email":([email isEqualToString:@""] || email.length == 0) ? @"" : email,
							@"img":avatar,
							@"policemancode":([policemancode isEqualToString:@""] || policemancode.length == 0) ? @"" : policemancode,
							@"idcardImg1":([imageUrlIDFront isEqualToString:@""] || imageUrlIDFront.length == 0) ? @"" : imageUrlIDFront,
							@"idcardImg2":([imageUrlIDBack isEqualToString:@""] || imageUrlIDBack.length == 0) ? @"" : imageUrlIDBack,
							};
	
	[[HACoreAPI core] POSTURLString:URL_AUTH_USER_UPDATE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
	
}

+ (void)authGetUidWithTokenSuccess:(void (^)(id ret))success
							 error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						   failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_GET_UID withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authGetUserInfoWithTokenSuccess:(void (^)(id ret))success
								  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
								failure:(void (^)(NSError *error))failure {
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	NSDictionary *param = @{
							@"token":[HAApp current].atoken,
							};
	[[HACoreAPI core] POSTURLString:URL_AUTH_USER_INFO withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}

+ (void)authVerificationWithName:(NSString *)name
				   imageURLFront:(NSString *)imageURLFront
					imageURLBack:(NSString *)imageURLBack
					userIdentity:(NSString *)useridentity
						userType:(NSString *)usertype
					 description:(NSString *)description
						  idCard:(NSString *)idcard
						 success:(void (^)(id ret))success
						   error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
						 failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	
	NSDictionary *param = @{
							@"name":name,
							@"idcard_img1":([imageURLFront isEqualToString:@""] || imageURLFront.length == 0) ? @"" : imageURLFront,
							@"idcard_img2":([imageURLBack isEqualToString:@""] || imageURLBack.length == 0) ? @"" : imageURLBack,
							@"useridentity":useridentity,
							@"usertype":usertype,
							@"description":description,
							@"idcard":([idcard isEqualToString:@""] || idcard.length == 0) ? @"" : idcard,
							@"atoken":[[HAApp current] atoken],
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_ID_VERIFICATION withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

+ (void)authChangePasswordWithPhone:(NSString *)phone
						   password:(NSString *)password
						rawPassword:(NSString *)rawPassword
							success:(void (^)(id ret))success
							  error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							failure:(void (^)(NSError *error))failure {
	
	if ([HAApp current].atoken == nil) {
		[[HACore core] logInnerError:@"请求 --> %s\n,原因 --> 缺少atoken \n",__func__];
		return;
	}
	NSDictionary *param = @{
							@"phone":phone,
							@"password":password,
							@"rawPassword":rawPassword,
							@"token":[HAApp current].atoken,
							};
	
	[[HACoreAPI core] GETURLString:URL_AUTH_UPDATE_PWD withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

// MARK: - FORGOT PASSWORD

+ (BOOL)authVerifyForgotPasswordNew:(UITextField *)tfNew confirm:(UITextField *)tfConfirm {
	
	if (![tfNew checkIsFilled] || ![tfConfirm checkIsFilled]) {
		return NO;
	}
	
	NSInteger minlength = [(NSNumber *)[[HACore core] valueForConfWithKey:@"auth-login-pwd-min-length"] integerValue];
	NSInteger maxlength = [(NSNumber *)[[HACore core] valueForConfWithKey:@"auth-login-pwd-max-length"] integerValue];
	
	if (![tfNew checkStringLengthBetween:minlength and:maxlength] || ![tfConfirm checkStringLengthBetween:minlength and:maxlength]) {
		return NO;
	}
	
	if (![tfNew.text isEqualToString:tfConfirm.text]) {
		[[HACore core] logInnerError:@"auth forgot password new password not the same"];
		return NO;
	}
	
	return YES;
}

+ (void)authForgotResetPassword:(NSString *)newpassword
						account:(NSString *)account
						  vcode:(NSString *)vcode
						success:(void (^)(id))success
						  error:(void (^)(NSInteger, NSString *, id))apierror
						failure:(void (^)(NSError *))failure {
	
	NSDictionary *param = @{
							//							@"deviceid":[[UIDevice currentDevice] uuid],
							@"phone":account,
							@"code":vcode,
							@"password":[newpassword md5Uppercase32],
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_FORGOT_RESET withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
}


+ (void)authForgotGetVcodeWithAccount:(NSString *)account
							  success:(void (^)(id ret))success
								error:(void (^)(NSInteger code, NSString *msg, id ret))apierror
							  failure:(void (^)(NSError *error))failure {
	NSDictionary *param = @{
							@"deviceid":[[UIDevice currentDevice] uuid],
							@"account":account,
							};
	[[HACoreAPI core] GETURLString:URL_AUTH_FORGOT_VCODE withParameters:param success:^(id ret) {
		success(ret);
	} error:^(NSInteger code, NSString *msg, id ret) {
		apierror(code, msg, ret);
	} failure:^(NSError *error) {
		failure(error);
	}];
	
}

// MARK: - 验证相关

+ (BOOL)authVerifyWithAccount:(UITextField *)accountField
						vcode:(UITextField *)vcode
					 passWord:(UITextField *)passWord
				  locationStr:(NSString *)locationStr
				  userTypeStr:(NSString *)userTypeStr {
	
	if (![accountField checkIsFilled] || ![vcode checkIsFilled] || ![passWord checkIsFilled]) {
		return NO;
	}
	
	//是否是手机号
	if (![accountField.text isPhoneNumber]) {
		[[HACore core] logInnerError:@"不是手机号"];
		return NO;
	}
	
	NSInteger minlength = 6;
	NSInteger maxlength = 16;
	
	if (![passWord checkStringLengthBetween:minlength and:maxlength]) {
		[[HACore core] logInnerError:@"密码位数不对"];
		return NO;
	}
	
	//地区验证
	if ([locationStr isEqualToString:@""] || locationStr.length == 0 || [userTypeStr isEqualToString:@""] || userTypeStr.length == 0) {
		[[HACore core] logInnerError:@"empty string"];
		return NO;
	}
	
	return YES;
}

+ (BOOL)authVerifyGetVcodeWithAccount:(UITextField *)accountField {
	
	if (![accountField checkIsFilled]) {
		return NO;
	}
	
	if (![accountField.text isPhoneNumber]) {
		[[HACore core] logInnerError:@"不是手机号"];
		return NO;
	}
	
	return YES;
}

+ (BOOL)authVerifyVcode:(UITextField *)vcode account:(UITextField *)accountField {
	
	if (![accountField checkIsFilled] || ![vcode checkIsFilled]) {
		return NO;
	}
	
	if (![accountField.text isPhoneNumber]) {
		[[HACore core] logInnerError:@"不是手机号"];
		return NO;
	}
	
	return YES;
	
}

+ (BOOL)authVerifyUserType:(NSString *)citycode {
	
	if ([citycode isEqualToString:@""] || citycode.length == 0) {
		[[HACore core] logInnerError:@"缺少城市编码字段"];
		return NO;
	}
	
	return YES;
}


@end
