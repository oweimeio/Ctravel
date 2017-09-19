//
//  HAUserPaxy.m
//  Pods
//
//  Created by FengkunMei on 2017/5/3.
//
//

#import "HAUserPaxy.h"
#import "FCFileManager.h"
#import "HACoordinate.h"
#import <LYCategory/LYCategory.h>

@implementation HAUserPaxy

// MARK: - INIT

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.mobile = [coder decodeObjectForKey:@"self.mobile"];
		self.avatar = [coder decodeObjectForKey:@"self.avatar"];
		self.gender = (UserGender) [coder decodeIntForKey:@"self.gender"];
		self.birthday = [coder decodeObjectForKey:@"self.birthday"];
		self.realname = [coder decodeObjectForKey:@"self.realname"];
		self.age = (NSUInteger) [coder decodeInt64ForKey:@"self.age"];
		self.IDNumber = [coder decodeObjectForKey:@"self.IDNumber"];
		self.authStatus = (HAIDAuthStatus) [coder decodeIntForKey:@"self.authStatus"];
		//		self.userType = (HAUserType) [coder decodeIntForKey:@"self.userType"];
		self.deptArea = [coder decodeObjectForKey:@"self.deptArea"];
		self.deptCenter = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"self.deptCenter.latitude"], [coder decodeDoubleForKey:@"self.deptCenter.longitude"]);
		self.yuntuKey = [coder decodeObjectForKey:@"self.yuntuKey"];
		self.yuntuTableID = [coder decodeObjectForKey:@"self.yuntuTableID"];
		self.yuntuID = [coder decodeObjectForKey:@"self.yuntuID"];
		self.userInfo = [coder decodeObjectForKey:@"self.userInfo"];
		self.onlineStatus = (HAPaxyOnlineStatus) [coder decodeIntForKey:@"self.onlineStatus"];
		self.roleID = [coder decodeObjectForKey:@"self.roleID"];
		self.roleName = [coder decodeObjectForKey:@"self.roleName"];
		
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	[coder encodeObject:self.mobile forKey:@"self.mobile"];
	[coder encodeObject:self.avatar forKey:@"self.avatar"];
	[coder encodeInt:self.gender forKey:@"self.gender"];
	[coder encodeObject:self.birthday forKey:@"self.birthday"];
	[coder encodeObject:self.realname forKey:@"self.realname"];
	[coder encodeInt64:self.age forKey:@"self.age"];
	[coder encodeObject:self.IDNumber forKey:@"self.IDNumber"];
	[coder encodeInt:self.authStatus forKey:@"self.authStatus"];
	//	[coder encodeInt:self.userType forKey:@"self.userType"];
	[coder encodeObject:self.deptArea forKey:@"self.deptArea"];
	[coder encodeDouble:self.deptCenter.latitude forKey:@"self.deptCenter.latitude"];
	[coder encodeDouble:self.deptCenter.longitude forKey:@"self.deptCenter.longitude"];
	[coder encodeObject:self.yuntuKey forKey:@"self.yuntuKey"];
	[coder encodeObject:self.yuntuTableID forKey:@"self.yuntuTableID"];
	[coder encodeObject:self.yuntuID forKey:@"self.yuntuID"];
	[coder encodeObject:self.userInfo forKey:@"self.userInfo"];
	[coder encodeInt:self.onlineStatus forKey:@"self.onlineStatus"];
	[coder encodeObject:self.roleID forKey:@"self.roleID"];
	[coder encodeObject:self.roleName forKey:@"self.roleName"];
	
}

- (id)copyWithZone:(NSZone *)zone {
	HAUserPaxy *copy = (HAUserPaxy *) [super copyWithZone:zone];
	
	if (copy != nil) {
		copy.mobile = self.mobile;
		copy.avatar = self.avatar;
		copy.gender = self.gender;
		copy.birthday = self.birthday;
		copy.realname = self.realname;
		copy.age = self.age;
		copy.IDNumber = self.IDNumber;
		copy.authStatus = self.authStatus;
//		copy.userType = self.userType;
		copy.deptArea = self.deptArea;
		copy.deptCenter = self.deptCenter;
		copy.yuntuKey = self.yuntuKey;
		copy.yuntuTableID = self.yuntuTableID;
		copy.yuntuID = self.yuntuID;
		copy.userInfo = self.userInfo;
		copy.onlineStatus = self.onlineStatus;
		copy.roleID = self.roleID;
		copy.roleName = self.roleName;
		
	}
	
	return copy;
}

// MARK: - METHED

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

// MARK: - OVERRIDE

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {

	_avatar = keyedValues[@"user"][@"img"];
	_realname = [NSString stringWithFormat:@"%@", keyedValues[@"user"][@"realname"]];
	// FIXME: 实名认证状态字段待确定
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
	// FIXME: 身份证号码字段待确定
	if (_authStatus == HAIDAuthStatusPassed && [keyedValues[@"user"] hasObjectWithKey:@"cardcode"]) {
		_IDNumber = keyedValues[@"user"][@"cardcode"];
		
		_birthday = [_IDNumber extractBirthdayFromIDNumber];
		_age = [_IDNumber extractAgeFromIDNumber];
		_gender = [[_IDNumber extractGenderFromIDNumber] isEqualToString:@"男"] ? UserGenderMale : ([[_IDNumber extractGenderFromIDNumber] isEqualToString:@"女"] ? UserGenderFemale : UserGenderNone);
	} else {
		_gender = UserGenderNone;
	}
	
//	NSString *userTypeString = keyedValues[@"user"][@"type"];
	_mobile = keyedValues[@"user"][@"phone"];
	_yuntuKey = keyedValues[@"yuntu"][@"key"];
	_yuntuTableID = keyedValues[@"yuntu"][@"tableid"];
	_yuntuID = keyedValues[@"user"][@"ytCode"];
	_roleID = keyedValues[@"user"][@"roleId"];
	_roleName = keyedValues[@"user"][@"roleName"];
	
	NSInteger onlineInt = [keyedValues[@"user"][@"isOnline"] integerValue];
	if (0 == onlineInt) {
		_onlineStatus = HAPaxyOnlineStatusIsLeave;
	} else if (1 == onlineInt) {
		_onlineStatus = HAPaxyOnlineStatusIsOnline;
	}
	
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
	return [NSString stringWithFormat:@"\nHAUserPaxy {\n\tUID = %@\n\tUsername = %@\n\tMobile = %@\n}\n",
			self.UID,
			_realname,
			_mobile];
}

@end
