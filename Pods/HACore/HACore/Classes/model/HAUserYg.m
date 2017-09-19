//
//  HAUserYg.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-18.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAUserYg.h"
#import <HACore/HACoreHeader.h>
#import "FCFileManager.h"

@implementation HAUserYg

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
	
	if ([keyedValues hasObjectWithKey:@"userinfo"]) {
		_name = [NSString stringWithFormat:@"%@",keyedValues[@"userinfo"][@"name"]];
		_avatar = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"icon"]];
		_gender = [keyedValues[@"userinfo"][@"gender"] integerValue] == 0 ? UserGenderFemale : UserGenderMale;
		_mobile = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"cellphone"]];
		_communityID = [keyedValues[@"userinfo"][@"communityid"] integerValue];
		_deptID = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"deptid"]];
		_address = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"address"]];
		_jobTitle = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"position"]];
		_jobNumber = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"number"]];
		_IDNumber = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"idcard"]];
		_unitName = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"unitTypeName"]];
		_yuntuID = [NSString stringWithFormat:@"%@", [keyedValues[@"userinfo"] hasObjectWithKey:@"yuntuid"] ? keyedValues[@"userinfo"][@"yuntuid"] : @""];
		if ([keyedValues[@"userinfo"] hasObjectWithKey:@"status"]) {
			_authStatus = [keyedValues[@"userinfo"][@"status"] integerValue];
		} else {
			_authStatus = HACoreYgIDAuthStatusNot;
		}
		
		if ([keyedValues[@"userinfo"] hasObjectWithKey:@"birthday"]) {
			_birthday = [keyedValues[@"userinfo"][@"birthday"] dateWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI];
		}
		
		if ([keyedValues[@"userinfo"] hasObjectWithKey:@"points"]) {
			_point = [keyedValues[@"userinfo"][@"points"] integerValue];
		}
		
		_type = [keyedValues[@"userinfo"][@"type"] integerValue];
		_userIdentity = [keyedValues[@"userinfo"][@"useridentity"] integerValue];
		
		if ([keyedValues[@"userinfo"] hasObjectWithKey:@"userTypeName"]) {
			_userTypeName = [NSString stringWithFormat:@"%@", keyedValues[@"userinfo"][@"userTypeName"]];
		}
		
	}
	
	if ([keyedValues hasObjectWithKey:@"community"]) {
		_area = [NSString stringWithFormat:@"%@", keyedValues[@"community"][@"area"]];
	}
	
	if ([keyedValues hasObjectWithKey:@"verifyInfo"]) {
		[keyedValues[@"verifyInfo"] hasObjectWithKey:@"idcardImg1"] ? _IDCardFront = keyedValues[@"verifyInfo"][@"idcardImg1"] : @"";
		[keyedValues[@"verifyInfo"] hasObjectWithKey:@"idcardImg2"] ? _IDCardBack = keyedValues[@"verifyInfo"][@"idcardImg2"] : @"";
		[keyedValues[@"verifyInfo"] hasObjectWithKey:@"usertype"] ? _userTypeID = keyedValues[@"verifyInfo"][@"usertype"] : @"";
		[keyedValues[@"verifyInfo"] hasObjectWithKey:@"useridentity"] ? _userIdentityID = keyedValues[@"verifyInfo"][@"useridentity"] : @"0";
	}
	
	if ([keyedValues hasObjectWithKey:@"lbsConfig"]) {
		[keyedValues[@"lbsConfig"] hasObjectWithKey:@"key"] ? _yuntuKey = keyedValues[@"lbsConfig"][@"key"] : @"";
		[keyedValues[@"lbsConfig"] hasObjectWithKey:@"tableid"] ? _yuntuTableID = keyedValues[@"lbsConfig"][@"tableid"] : @"";
	}
	
	_userInfo = keyedValues;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.name = [coder decodeObjectForKey:@"self.name"];
		self.avatar = [coder decodeObjectForKey:@"self.avatar"];
		self.gender = (UserGender) [coder decodeIntForKey:@"self.gender"];
		self.mobile = [coder decodeObjectForKey:@"self.mobile"];
		self.communityID = [coder decodeIntForKey:@"self.communityID"];
		self.deptID = [coder decodeObjectForKey:@"self.deptId"];
		self.yuntuKey = [coder decodeObjectForKey:@"self.yuntuKey"];
		self.yuntuTableID = [coder decodeObjectForKey:@"self.yuntuTableID"];
		self.yuntuID = [coder decodeObjectForKey:@"self.yuntuID"];
		self.authStatus = (HACoreYgIDAuthStatus) [coder decodeIntForKey:@"self.authStatus"];
		self.birthday = [coder decodeObjectForKey:@"self.birthday"];
		self.address = [coder decodeObjectForKey:@"self.address"];
		self.jobTitle = [coder decodeObjectForKey:@"self.position"];
		self.jobNumber = [coder decodeObjectForKey:@"self.jobNumber"];
		self.IDNumber = [coder decodeObjectForKey:@"self.IDNumber"];
		self.IDCardFront = [coder decodeObjectForKey:@"self.IDCardFront"];
		self.IDCardBack = [coder decodeObjectForKey:@"self.IDCardBack"];
		self.point = [coder decodeIntForKey:@"self.point"];
		self.area = [coder decodeObjectForKey:@"self.area"];
		self.userTypeID = [coder decodeObjectForKey:@"self.userTypeID"];
		self.userIdentityID = [coder decodeObjectForKey:@"self.userIdentityID"];
		self.userTypeName = [coder decodeObjectForKey:@"self.userTypeName"];
		self.unitName = [coder decodeObjectForKey:@"self.unitName"];
		self.type = (HACoreYgUserType)[coder decodeIntegerForKey:@"self.type"];
		self.userIdentity = [coder decodeIntegerForKey:@"self.userIdentity"];
		self.userInfo = [coder decodeObjectForKey:@"self.user.info"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	[coder encodeObject:self.name forKey:@"self.name"];
	[coder encodeObject:self.avatar forKey:@"self.avatar"];
	[coder encodeInt:self.gender forKey:@"self.gender"];
	[coder encodeObject:self.mobile forKey:@"self.mobile"];
	[coder encodeInteger:self.communityID forKey:@"self.communityID"];
	[coder encodeObject:self.deptID forKey:@"self.deptId"];
	[coder encodeObject:self.yuntuKey forKey:@"self.yuntuKey"];
	[coder encodeObject:self.yuntuTableID forKey:@"self.yuntuTableID"];
	[coder encodeObject:self.yuntuID forKey:@"self.yuntuID"];
	[coder encodeInt:self.authStatus forKey:@"self.authStatus"];
	[coder encodeObject:self.birthday forKey:@"self.birthday"];
	[coder encodeObject:self.address forKey:@"self.address"];
	[coder encodeObject:self.jobTitle forKey:@"self.position"];
	[coder encodeObject:self.jobNumber forKey:@"self.jobNumber"];
	[coder encodeObject:self.IDNumber forKey:@"self.IDNumber"];
	[coder encodeObject:self.IDCardFront forKey:@"self.IDCardFront"];
	[coder encodeObject:self.IDCardBack forKey:@"self.IDCardBack"];
	[coder encodeInteger:self.point forKey:@"self.point"];
	[coder encodeObject:self.area forKey:@"self.area"];
	[coder encodeObject:self.userTypeID forKey:@"self.userTypeID"];
	[coder encodeObject:self.userIdentityID forKey:@"self.userIdentityID"];
	[coder encodeObject:self.userTypeName forKey:@"self.userTypeName"];
	[coder encodeObject:self.unitName forKey:@"self.unitName"];
	[coder encodeInteger:self.type forKey:@"self.type"];
	[coder encodeInteger:self.userIdentity forKey:@"self.userIdentity"];
	[coder encodeObject:self.userInfo forKey:@"self.user.info"];
}

- (id)copyWithZone:(nullable NSZone *)zone {
	HAUserYg *copy = (HAUserYg *) [super copyWithZone:zone];

	if (copy != nil) {
		copy.name = self.name;
		copy.avatar = self.avatar;
		copy.gender = self.gender;
		copy.mobile = self.mobile;
		copy.communityID = self.communityID;
		copy.deptID = self.deptID;
		copy.yuntuKey = self.yuntuKey;
		copy.yuntuTableID = self.yuntuTableID;
		copy.yuntuID = self.yuntuID;
		copy.authStatus = self.authStatus;
		copy.birthday = self.birthday;
		copy.address = self.address;
		copy.jobTitle = self.jobTitle;
		copy.jobNumber = self.jobNumber;
		copy.IDNumber = self.IDNumber;
		copy.IDCardFront = self.IDCardFront;
		copy.IDCardBack = self.IDCardBack;
		copy.point = self.point;
		copy.area = self.area;
		copy.userTypeID = self.userTypeID;
		copy.userIdentityID = self.userIdentityID;
		copy.userTypeName = self.userTypeName;
		copy.unitName = self.unitName;
		copy.type = self.type;
		copy.userIdentity = self.userIdentity;
		copy.userInfo = self.userInfo;
	}

	return copy;
}

+ (instancetype)userWithUID:(NSString *)theUID {

	if (theUID == nil || ![theUID isKindOfClass:[NSString class]] || [theUID isEqualToString:@""]) {
		[[HACore core] logInnerError:@"user UID not correct"];
		return nil;
	}

	NSString *userfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];

	if (![FCFileManager isDirectoryItemAtPath:userfolder]) {
		[[HACore core] logInnerError:@"user yg folder not exist"];

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

@end
