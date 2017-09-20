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
	[NSKeyedArchiver archiveRootObject:[self class] toFile:userpath];
}

//- (id)copyWithZone:(NSZone *)zone {
//    User *copy = (User *) [super copyWithZone:zone];
//    if (copy != nil) {
//        copy.userId = self.userId;
//        copy.firstName = self.firstName;
//        copy.familyName = self.familyName;
//        copy.phone = self.phone;
//        copy.avatar = self.avatar;
//    }
//    return copy;
//}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.userId = [coder decodeObjectForKey:@"self.userId"];
        self.firstName = [coder decodeObjectForKey:@"self.firstName"];
        self.familyName = [coder decodeObjectForKey:@"self.familyName"];
        self.phone = [coder decodeObjectForKey:@"self.phone"];
        self.avatar = [coder decodeObjectForKey:@"self.avatar"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.userId forKey:@"self.userId"];
    [coder encodeObject:self.firstName forKey:@"self.firstName"];
    [coder encodeObject:self.familyName forKey:@"self.familyName"];
    [coder encodeObject:self.phone forKey:@"self.phone"];
    [coder encodeObject:self.avatar forKey:@"self.avatar"];
}


@end
