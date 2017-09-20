//
//  User.h
//  Ctravel
//
//  Created by apple on 2017/9/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *familyName;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *avatar;

+ (instancetype)sharedUser;

- (void)saveUserData;

- (instancetype)getUserData;

@end
