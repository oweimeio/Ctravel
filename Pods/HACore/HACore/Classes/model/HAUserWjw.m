//
//  HAUserWjw.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-01.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAUserWjw.h"
#import "FCFileManager.h"
#import "HACoordinate.h"
#import <LYCategory/LYCategory.h>

@implementation HAUserWjw

// MARK: - INIT

- (id)copyWithZone:(NSZone *)zone {
	HAUserWjw *copy = (HAUserWjw *) [super copyWithZone:zone];

	if (copy != nil) {
		copy.mobile = self.mobile;
		copy.username = self.username;
		copy.avatar = self.avatar;
		copy.gender = self.gender;
		copy.birthday = self.birthday;
		copy.realname = self.realname;
		copy.age = self.age;
		copy.IDNumber = self.IDNumber;
		copy.authStatus = self.authStatus;
		copy.userType = self.userType;
		copy.deptArea = self.deptArea;
		copy.deptCenter = self.deptCenter;
		copy.yuntuKey = self.yuntuKey;
		copy.yuntuTableID = self.yuntuTableID;
		copy.userInfo = self.userInfo;
	}

	return copy;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.mobile = [coder decodeObjectForKey:@"self.mobile"];
		self.username = [coder decodeObjectForKey:@"self.username"];
		self.avatar = [coder decodeObjectForKey:@"self.avatar"];
		self.gender = (UserGender) [coder decodeIntForKey:@"self.gender"];
		self.birthday = [coder decodeObjectForKey:@"self.birthday"];
		self.realname = [coder decodeObjectForKey:@"self.realname"];
		self.age = (NSUInteger) [coder decodeInt64ForKey:@"self.age"];
		self.IDNumber = [coder decodeObjectForKey:@"self.IDNumber"];
		self.authStatus = (HAIDAuthStatus) [coder decodeIntForKey:@"self.authStatus"];
		self.userType = (HAUserType) [coder decodeIntForKey:@"self.userType"];
		self.deptArea = [coder decodeObjectForKey:@"self.deptArea"];
		self.deptCenter = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"self.deptCenter.latitude"], [coder decodeDoubleForKey:@"self.deptCenter.longitude"]);
		self.yuntuKey = [coder decodeObjectForKey:@"self.yuntuKey"];
		self.yuntuTableID = [coder decodeObjectForKey:@"self.yuntuTableID"];
		self.userInfo = [coder decodeObjectForKey:@"self.userInfo"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	[coder encodeObject:self.mobile forKey:@"self.mobile"];
	[coder encodeObject:self.username forKey:@"self.username"];
	[coder encodeObject:self.avatar forKey:@"self.avatar"];
	[coder encodeInt:self.gender forKey:@"self.gender"];
	[coder encodeObject:self.birthday forKey:@"self.birthday"];
	[coder encodeObject:self.realname forKey:@"self.realname"];
	[coder encodeInt64:self.age forKey:@"self.age"];
	[coder encodeObject:self.IDNumber forKey:@"self.IDNumber"];
	[coder encodeInt:self.authStatus forKey:@"self.authStatus"];
	[coder encodeInt:self.userType forKey:@"self.userType"];
	[coder encodeObject:self.deptArea forKey:@"self.deptArea"];
	[coder encodeDouble:self.deptCenter.latitude forKey:@"self.deptCenter.latitude"];
	[coder encodeDouble:self.deptCenter.longitude forKey:@"self.deptCenter.longitude"];
	[coder encodeObject:self.yuntuKey forKey:@"self.yuntuKey"];
	[coder encodeObject:self.yuntuTableID forKey:@"self.yuntuTableID"];
	[coder encodeObject:self.userInfo forKey:@"self.userInfo"];
}

// MARK: - METHOD

+ (instancetype)userWithUID:(NSString *)theUID {
	
	if (theUID == nil || ![theUID isKindOfClass:[NSString class]] || [theUID isEqualToString:@""]) {
		[[HACore core] logInnerError:@"user UID not correct"];
		return nil;
	}
	
	NSString *userfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
	
	if (![FCFileManager isDirectoryItemAtPath:userfolder]) {
		[[HACore core] logInnerError:@"user wjw folder not exist"];
		
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

- (BOOL)hasOperationPrivilege {
	
	if (_authStatus == HAIDAuthStatusPassed && _userType > HAUserTypeResident) {
		return YES;
	}
	
	[[HACore core] logInnerWarning:@"UserType = %@, Auth = %@", @(_userType), @(_authStatus)];
	
	return NO;
}

// MARK: - OVERRIDE

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
	
	_username = [NSString stringWithFormat:@"%@", keyedValues[@"user"][@"username"]];
	_avatar = keyedValues[@"user"][@"img"];
	
	/*
	// NO-USE KEY -> user.sex
	if ([keyedValues[@"user"] hasObjectWithKey:@"sex"]) {
		_gender = [keyedValues[@"user"][@"sex"] integerValue] == 0 ? UserGenderFemale : ([keyedValues[@"user"][@"sex"] integerValue] == 1 ? UserGenderMale : UserGenderNone);
	} else {
		_gender = UserGenderNone;
	}
	*/
	
	_realname = [NSString stringWithFormat:@"%@", keyedValues[@"user"][@"realname"]];
	
	NSString *authString = keyedValues[@"user"][@"auth"];
	if (authString == nil || [authString isEqualToString:@"noAuth"]) {
		_authStatus = HAIDAuthStatusNot;
	} else if ([authString isEqualToString:@"authing"]) {
		_authStatus = HAIDAuthStatusOngoing;
	} else if ([authString isEqualToString:@"authed"]) {
		_authStatus = HAIDAuthStatusPassed;
	} else if ([authString isEqualToString:@"authFail"]) {
		_authStatus = HAIDAuthStatusRejected;
	}
	
	if (_authStatus == HAIDAuthStatusPassed && [keyedValues[@"user"] hasObjectWithKey:@"cardcode"]) {
		_IDNumber = keyedValues[@"user"][@"cardcode"];
		
		_birthday = [_IDNumber extractBirthdayFromIDNumber];
		_age = [_IDNumber extractAgeFromIDNumber];
		_gender = [[_IDNumber extractGenderFromIDNumber] isEqualToString:@"男"] ? UserGenderMale : ([[_IDNumber extractGenderFromIDNumber] isEqualToString:@"女"] ? UserGenderFemale : UserGenderNone);
	} else {
		_gender = UserGenderNone;
	}
	
	NSString *userTypeString = keyedValues[@"user"][@"type"];
	if ([userTypeString isEqualToString:@"superAdmin"]) {
		_userType = HAUserTypeSuper;
	} else if ([userTypeString isEqualToString:@"admin"]) {
		_userType = HAUserTypeAdmin;
	} else if ([userTypeString isEqualToString:@"backUser"]) {
		_userType = HAUserTypeOperator;
	} else {
		_userType = HAUserTypeResident;
	}
	
	_mobile = keyedValues[@"user"][@"phone"];
	_yuntuKey = keyedValues[@"yuntu"][@"key"];
	_yuntuTableID = keyedValues[@"yuntu"][@"tableid"];
	
	
	if ([keyedValues[@"user"] hasObjectWithKey:@"dept"]) {
		
		NSArray *deptCenterArray = [keyedValues[@"user"][@"dept"][@"location"] componentsSeparatedByString:@","];
		if ([deptCenterArray count] == 2) {
			_deptCenter = CLLocationCoordinate2DMake([deptCenterArray.lastObject doubleValue], [deptCenterArray.firstObject doubleValue]);
		}
		deptCenterArray = nil;
		
		NSMutableArray *pois = [NSMutableArray arrayWithCapacity:1];
		for (NSString *poistring in [keyedValues[@"user"][@"dept"][@"xyz"] componentsSeparatedByString:@"|"]) {
			NSArray *poi = [poistring componentsSeparatedByString:@","];
			if ([poi count] == 2) {
				[pois addObject:[HACoordinate coordinateWithLatitude:[poi.lastObject doubleValue] andLongitude:[poi.firstObject doubleValue]]];
			}
		}
		_deptArea = [NSArray arrayWithArray:pois];
		[pois removeAllObjects];
		pois = nil;
	}
	
	_userInfo = keyedValues;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"\nHAUserWjw {\n\tUID = %@\n\tUsername = %@\n\tMobile = %@\n}\n",
			self.UID,
			_username,
			_mobile];
}

@end
