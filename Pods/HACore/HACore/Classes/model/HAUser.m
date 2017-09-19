//
//  HAUser.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAUser.h"
#import "FCFileManager.h"
#import "HACore.h"
#import "HAConstHeader.h"
#import "HACoreData.h"
#import <LYCategory/LYCategory.h>

@implementation HAUser

/*
- (NSDictionary<NSString *,id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys {
	return nil;
}
*/

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
	
	_name = keyedValues[@"userinfo"][@"name"];
	_gender = [keyedValues[@"userinfo"][@"gender"] integerValue] == 1 ? UserGenderMale : UserGenderFemale;
	_IDNumer = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"idcard"]];
	_mobile = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"cellphone"]];
	_avatar = [NSString stringWithFormat:@"http://%@", keyedValues[@"userinfo"][@"icon"]];
}

// MARK: - PROTOCOLS

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.name = [coder decodeObjectForKey:@"self.name"];
		self.gender = (UserGender)[coder decodeIntegerForKey:@"self.gender"];
		self.IDNumer = [coder decodeObjectForKey:@"self.ID.number"];
		self.mobile = [coder decodeObjectForKey:@"self.mobile"];
		self.avatar = [coder decodeObjectForKey:@"self.avatar"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.name forKey:@"self.name"];
	[coder encodeInteger:self.gender forKey:@"self.gender"];
	[coder encodeObject:self.IDNumer forKey:@"self.ID.number"];
	[coder encodeObject:self.mobile forKey:@"self.mobile"];
	[coder encodeObject:self.avatar forKey:@"self.avatar"];
}

- (id)copyWithZone:(NSZone *)zone {
	HAUser *copy = (HAUser *)[[[self class] allocWithZone:zone] init];

	if (copy != nil) {
		copy.name = self.name;
		copy.gender = self.gender;
		copy.IDNumer = self.IDNumer;
		copy.mobile = self.mobile;
		copy.avatar = self.avatar;
	}

	return copy;
}

// MARK: - METHOD

+ (instancetype)userWithUID:(NSString *)theUID {
	
	if (theUID == nil || [theUID isKindOfClass:[NSString class]] == NO || [theUID isEqualToString:@""]) {
		[[HACore core] logInnerError:@"user UID not correct"];
		return nil;
	}
	
	NSString *userfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
	
	if (![FCFileManager isDirectoryItemAtPath:userfolder]) {
		[[HACore core] logInnerError:@"user folder not exist"];
		
		[FCFileManager createDirectoriesForPath:userfolder];
		return nil;
	}
	
	NSString *userpath = [userfolder stringByAppendingFormat:@"/%@", theUID];
	
	if (![FCFileManager isFileItemAtPath:userpath]) {
		[[HACore core] logInnerError:@"user file not exist"];
		return nil;
	}
	
	return [NSKeyedUnarchiver unarchiveObjectWithFile:userpath];
}

// MARK: - OVERRIDE

- (NSString *)description {
	return [NSString stringWithFormat:@"\nHAUser {\n\tUID = %@\n\tName = %@\n\tID Number = %@\n}\n",
			self.UID,
			_name,
			_IDNumer];
}

@end
