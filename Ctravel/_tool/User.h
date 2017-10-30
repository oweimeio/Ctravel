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

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *familyName;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *avatarUrl;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *registerTime;

@property (nonatomic, strong) NSString *about;

@property (nonatomic, strong) NSString *language;

@property (nonatomic, strong) NSString *school;

@property (nonatomic, strong) NSString *job;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *validCode;

+ (instancetype)sharedUser;

- (void)saveUserData;

- (instancetype)getUserData;

@end
