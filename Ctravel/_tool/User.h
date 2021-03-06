//
//  User.h
//  Ctravel
//
//  Created by apple on 2017/9/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *token;
	
@property (nonatomic, strong) NSString *imToken;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *familyName;

@property (nonatomic, assign) NSInteger gender;
	
@property (nonatomic, assign) NSString *bornDate;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *avatarUrl;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *registerTime;

@property (nonatomic, strong) NSString *about;

@property (nonatomic, strong) NSString *language;

@property (nonatomic, strong) NSString *school;

@property (nonatomic, strong) NSString *job;

@property (nonatomic, strong) NSString *email;
	
@property (nonatomic, strong) NSString *idCardNum;

@property (nonatomic, strong) NSString *idCardImageUrl;
//验证码
@property (nonatomic, strong) NSString *validCode;

//支付宝账号
@property (nonatomic, strong) NSString *payAccount;

//是否是达人
@property (nonatomic, assign) BOOL isServer;

//是否发布过
@property (nonatomic, assign) BOOL isPublished;

+ (instancetype)sharedUser;

- (void)saveUserData;

- (instancetype)getUserData;

@end
