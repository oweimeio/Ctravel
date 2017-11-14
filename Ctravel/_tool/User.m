//
//  User.m
//  Ctravel
//
//  Created by apple on 2017/9/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "User.h"
#import "PreHeader.h"

@implementation User

+ (instancetype)sharedUser {
	static User *user = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		user = [[User alloc] init];
	});
	return user;
}

- (instancetype)getUserData {
	NSString *userfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
	
	if (![FCFileManager isDirectoryItemAtPath:userfolder]) {
		[[HACore core] logInnerError:@"user folder not exist"];
		
		[FCFileManager createDirectoriesForPath:userfolder];
		return nil;
	}
	
	NSString *userpath = [userfolder stringByAppendingFormat:@"/ctravelUser"];
	
	if (![FCFileManager isFileItemAtPath:userpath]) {
		[[HACore core] logInnerError:@"user file not exist"];
		return nil;
	}
	
	return [NSKeyedUnarchiver unarchiveObjectWithFile:userpath];
}

- (void)saveUserData {
	NSString *userfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
	if (![FCFileManager isDirectoryItemAtPath:userfolder]) {
		[[HACore core] logInnerError:@"user folder not exist"];
		
		[FCFileManager createDirectoriesForPath:userfolder];
	}
	NSString *userpath = [userfolder stringByAppendingFormat:@"/ctravelUser"];
	
	if (![FCFileManager isFileItemAtPath:userpath]) {
		[[HACore core] logInnerError:@"user file not exist"];
	}
	[NSKeyedArchiver archiveRootObject:self toFile:userpath];
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
	_firstName = keyedValues[@"firstName"];
	_familyName = keyedValues[@"familyName"];
	_userId = keyedValues[@"customerId"];
	_gender = [keyedValues[@"gender"] isEqualToString:@"男"] ? 1 : 0;
}

- (id)copyWithZone:(NSZone *)zone {
//    User *copy = [self class] [super copyWithZone:zone];
//    if (copy != nil) {
//        copy.userId = self.userId;
//        copy.firstName = self.firstName;
//        copy.familyName = self.familyName;
//        copy.phone = self.phone;
//        copy.avatar = self.avatar;
//    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.token = [coder decodeObjectForKey:@"self.token"];
		self.imToken = [coder decodeObjectForKey:@"self.imToken"];
        self.isLogin = [coder decodeBoolForKey:@"self.isLogin"];
        self.userId = [coder decodeObjectForKey:@"self.userId"];
        self.firstName = [coder decodeObjectForKey:@"self.firstName"];
        self.familyName = [coder decodeObjectForKey:@"self.familyName"];
		self.gender = [coder decodeIntegerForKey:@"self.gender"];
		self.bornDate = [coder decodeObjectForKey:@"self.bornDate"];
        self.phone = [coder decodeObjectForKey:@"self.phone"];
        self.avatarUrl = [coder decodeObjectForKey:@"self.avatarUrl"];
        self.city = [coder decodeObjectForKey:@"self.avatarUrl"];
        self.registerTime = [coder decodeObjectForKey:@"self.avatarUrl"];
        self.about = [coder decodeObjectForKey:@"self.about"];
        self.language = [coder decodeObjectForKey:@"self.language"];
        self.school = [coder decodeObjectForKey:@"self.school"];
        self.job = [coder decodeObjectForKey:@"self.job"];
        self.email = [coder decodeObjectForKey:@"self.email"];
        self.validCode = [coder decodeObjectForKey:@"self.validCode"];
		self.payAccount = [coder decodeObjectForKey:@"self.payAccount"];
		self.idCardNum = [coder decodeObjectForKey:@"self.idCardNum"];
		self.idCardImageUrl = [coder decodeObjectForKey:@"self.idCardImageUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.token forKey:@"self.token"];
	[coder encodeObject:self.imToken forKey:@"self.imToken"];
    [coder encodeBool:self.isLogin forKey:@"self.isLogin"];
    [coder encodeObject:self.userId forKey:@"self.userId"];
    [coder encodeObject:self.firstName forKey:@"self.firstName"];
    [coder encodeObject:self.familyName forKey:@"self.familyName"];
	[coder encodeInteger:self.gender forKey:@"self.gender"];
	[coder encodeObject:self.bornDate forKey:@"self.bornDate"];
    [coder encodeObject:self.phone forKey:@"self.phone"];
    [coder encodeObject:self.avatarUrl forKey:@"self.avatarUrl"];
    [coder encodeObject:self.city forKey:@"self.city"];
    [coder encodeObject:self.registerTime forKey:@"self.registerTime"];
    [coder encodeObject:self.about forKey:@"self.about"];
    [coder encodeObject:self.language forKey:@"self.language"];
    [coder encodeObject:self.school forKey:@"self.school"];
    [coder encodeObject:self.job forKey:@"self.job"];
    [coder encodeObject:self.email forKey:@"self.email"];
    [coder encodeObject:self.validCode forKey:@"self.validCode"];
	[coder encodeObject:self.payAccount forKey:@"self.payAccount"];
	[coder encodeObject:self.idCardNum forKey:@"self.idCardNum"];
	[coder encodeObject:self.idCardImageUrl forKey:@"self.idCardImageUrl"];
}


@end
