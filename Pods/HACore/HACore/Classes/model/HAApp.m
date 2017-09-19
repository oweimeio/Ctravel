//
//  HAApp.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAApp.h"
#import "HAConstHeader.h"
#import "HACore.h"
#import "FCFileManager.h"
#import "HAModelHeader.h"
#import "HACore+Authorization.h"

@interface HAApp ()

@end

@implementation HAApp

// MARK: - INIT

- (id)copyWithZone:(NSZone *)zone {
	HAApp *copy = (HAApp *) [super copyWithZone:zone];

	if (copy != nil) {
		copy.isLoggedIn = self.isLoggedIn;
		copy.userID = self.userID;
		copy.atoken = self.atoken;
		copy.verifyCode = self.verifyCode;
		copy.deviceToken = self.deviceToken;
		copy.getuiID = self.getuiID;
		copy.lastLogin = self.lastLogin;
		copy.appType = self.appType;
		copy.badgeMessage = self.badgeMessage;
	}

	return copy;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.isLoggedIn = [coder decodeBoolForKey:@"self.isLoggedIn"];
		self.userID = [coder decodeObjectForKey:@"self.userID"];
		self.atoken = [coder decodeObjectForKey:@"self.atoken"];
		self.verifyCode = [coder decodeObjectForKey:@"self.verifyCode"];
		self.deviceToken = [coder decodeObjectForKey:@"self.deviceToken"];
		self.getuiID = [coder decodeObjectForKey:@"self.getuiID"];
		self.lastLogin = [coder decodeObjectForKey:@"self.lastLogin"];
		self.appType = (AppType) [coder decodeIntForKey:@"self.appType"];
		self.badgeMessage = [coder decodeIntegerForKey:@"self.badgeMessage"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	[coder encodeBool:self.isLoggedIn forKey:@"self.isLoggedIn"];
	[coder encodeObject:self.userID forKey:@"self.userID"];
	[coder encodeObject:self.atoken forKey:@"self.atoken"];
	[coder encodeObject:self.verifyCode forKey:@"self.verifyCode"];
	[coder encodeObject:self.deviceToken forKey:@"self.deviceToken"];
	[coder encodeObject:self.getuiID forKey:@"self.getuiID"];
	[coder encodeObject:self.lastLogin forKey:@"self.lastLogin"];
	[coder encodeInt:self.appType forKey:@"self.appType"];
	[coder encodeInteger:self.badgeMessage forKey:@"self.badgeMessage"];
}

- (instancetype)init {
	if (self = [super init]) {
		
		self.UID = @"default";
		
		_isLoggedIn = NO;
		_atoken = nil;
		_userID = nil;
		_deviceToken = nil;
		_getuiID = nil;
		_verifyCode = nil;
		_lastLogin = nil;
		_appType = AppTypeLogin;
		_badgeMessage = 0;
		
		// GET PERSISTED DATA
		[self synchronize];
		
		// LISTEN TO USER UPDATED NOTIFICATION
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userProfileUpdatedAtRemote) name:NOTIF_USER_UPDATED object:nil];
	}
	return self;
}

+ (instancetype)current {
	static HAApp *currentHAApp;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		currentHAApp = [[HAApp alloc] init];
	});
	return currentHAApp;
}

// MARK: - PROPERTY

- (void)setBadgeMessage:(NSInteger)badgeMessage {
	_badgeMessage = badgeMessage;
	
	/*
	NSInteger max = [[[HACore core] valueForConfWithKey:@"core-app-badge-limit-max"] integerValue];
	
	if (_badgeMessage > max) {
		_badgeMessage = max;
	}
	*/
}

- (NSString *)badge {
	
	if (_badgeMessage <= 0) {
		return @"";
	}
	
	NSInteger max = [[[HACore core] valueForConfWithKey:@"core-app-badge-limit-max"] integerValue];
    if (!max) {
        NSString *confpath = confpath = [[NSBundle bundleWithIdentifier:LIB_HACONF_BUNDLE_ID] pathForResource:@"com.huaaotech.core.conf" ofType:@"plist"];
        NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
        max = [conf[@"core-app-badge-limit-max"][@"conf-value"] integerValue];
        if (!max) {
            max = 99;
        }
    }
	NSString *ret;
	if (_badgeMessage > max) {
		ret = [NSString stringWithFormat:@"%@+", @(max)];
	} else {
		ret = [NSString stringWithFormat:@"%@", @(_badgeMessage)];
	}
	return ret;
}

// MARK: - METHOD

- (void)updateUserLoggedIn:(NSDictionary *)values {
	
	// DIVIDE USER
	NSString *baseurl = [[HACore core] valueForConfWithKey:[HACore core].debug ? @"core-net-domain-dev" : @"core-net-domain"];
	
	if ([baseurl containsString:@"www.huaaotech.date"] || [baseurl containsString:@"www.huaaotech.tech"]) {
		// WJW
		[self updateUserWjwLoggedIn:values];
		return;
	} else if ([baseurl containsString:@"sun."]) {
		// YGWJW
		[self updateUserYgwjwLoggedIn:values];
		return;
	} else if ([baseurl containsString:@"wxy."]) {
		// PAXY
		[self updateUserPaxyLoggedIn:values];
		return;
	} else if ([baseurl containsString:@"ejw."]) {
		// WJW-STANDARD
		[self updateUserWjwLoggedIn:values];
		return;
	}
}

- (void)updateUserWjwLoggedIn:(NSDictionary *)values {
	
	if (values == nil) {
		return;
	}
	
	_isLoggedIn = YES;
	_atoken = values[@"token"];
	_userID = [NSString stringWithFormat:@"%@", values[@"user"][@"id"]];
	_appType = AppTypeResident;
	_lastLogin = [NSString stringWithFormat:@"%@", values[@"user"][@"phone"]];
	
	HAUserWjw *user = [[HAUserWjw alloc] init];
	user.UID = _userID;
	[user setValuesForKeysWithDictionary:values];
	[user persist];
	
	[self persist];
}

- (void)updateUserWjw {
	
	if ([self isLoggedIn] == NO || _atoken == nil) {
		NSLog(@"NIL TOKEN");
		return;
	}
	
	[[HACoreAPI core] GETURLString:URL_AUTH_USER_INFO withParameters:@{@"token":_atoken,} success:^(id ret) {
		
		NSMutableDictionary *result = [ret[@"data"] mutableCopy];
		[result setObject:_atoken forKey:@"token"];
		[self updateUserWjwLoggedIn:result];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_CHANGED object:nil];
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (HAUserWjw *)wjwUser {
	return [HAUserWjw userWithUID:[HAApp current].userID];
	
}

- (void)updateUserYgwjwLoggedIn:(NSDictionary *)values {
	if (values == nil) {
		return;
	}
	
	_isLoggedIn = YES;
	_atoken = values[@"atoken"];
	_userID = [NSString stringWithFormat:@"%@", values[@"userinfo"][@"uid"]];
	_appType = AppTypeResident;
	_lastLogin = [NSString stringWithFormat:@"%@", values[@"userinfo"][@"cellphone"]];
	
	HAUserYg *user = [[HAUserYg alloc] init];
	user.UID = _userID;
	[user setValuesForKeysWithDictionary:values];
	[user persist];
	
	[self persist];

}

- (void)updateUserYgwjw {
	if ([self isLoggedIn] == NO || _atoken == nil) {
		NSLog(@"NIL TOKEN");
		return;
	}
	
	[[HACoreAPI core] GETURLString:URL_AUTH_USER_YGWJW_UPDATE withParameters:@{@"atoken":_atoken, @"uid":_userID} success:^(id ret) {
		NSMutableDictionary *result = [ret[@"data"] mutableCopy];
		[result setObject:_atoken forKey:@"atoken"];
		[self updateUserYgwjwLoggedIn:result];
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_CHANGED object:nil];
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (void)updateUserBfztc {
	if ([self isLoggedIn] == NO || _atoken == nil) {
		NSLog(@"NIL TOKEN");
		return;
	}
	
	[[HACoreAPI core] GETURLString:URL_AUTH_USER_YGWJW_UPDATE withParameters:@{@"atoken":_atoken, @"uid":_userID} success:^(id ret) {
		
		NSMutableDictionary *result = [ret[@"data"] mutableCopy];
		[result setObject:_atoken forKey:@"atoken"];
		[self updateUserYgwjwLoggedIn:result];
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_CHANGED object:nil];
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];

}

- (HAUserYg *)ygUser {
	return [HAUserYg userWithUID:[HAApp current].userID];
}

- (void)updateUserPaxyLoggedIn:(NSDictionary *)values {
	if (values == nil) {
		return;
	}
	
	_isLoggedIn = YES;
	_atoken = values[@"token"];
	_userID = [NSString stringWithFormat:@"%@", values[@"user"][@"id"]];
	_appType = AppTypeLogin;
	_lastLogin = [NSString stringWithFormat:@"%@", values[@"user"][@"phone"]];
	
	HAUserPaxy *user = [[HAUserPaxy alloc] init];
	user.UID = _userID;
	[user setValuesForKeysWithDictionary:values];
	[user persist];
	
	[self persist];
	
}

- (void)updateUserPaxy {
	if ([self isLoggedIn] == NO || _atoken == nil) {
		NSLog(@"NIL TOKEN");
		return;
	}
	
	[[HACoreAPI core] GETURLString:URL_AUTH_USER_PAXY_INFO withParameters:@{@"token":_atoken,} success:^(id ret) {
		
		NSMutableDictionary *result = [ret[@"data"] mutableCopy];
		[result setObject:_atoken forKey:@"token"];
		[self updateUserPaxyLoggedIn:result];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_CHANGED object:nil];
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (HAUserPaxy *)paxyUser {
	return [HAUserPaxy userWithUID:[HAApp current].userID];
}

- (void)logout {
	
	_isLoggedIn = NO;
	_atoken = nil;
	_userID = nil;
	_verifyCode = nil;
	[self persist];
	
	// DONE: POST NOTIFICATION
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_LOGOUT object:nil];
}

// MARK: PRIVATE METHOD

- (void)synchronize {
	
	NSString *appfolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/HAApp"];
	
	if (![FCFileManager isDirectoryItemAtPath:appfolder]) {
		// NOT EXIST
		// THEN
		// CREATE
		return;
	}
	
	NSString *apppath = [appfolder stringByAppendingFormat:@"/%@", self.UID];
	
	if (![FCFileManager isFileItemAtPath:apppath]) {
		// NOT EXIST
		// THEN CREATE AND WRITE
		return;
	}
	
	// HAVE FILE
	// THEN
	// READ
	HAApp *app = (HAApp *)[NSKeyedUnarchiver unarchiveObjectWithFile:apppath];// [FCFileManager readFileAtPathAsData:apppath];
	
	// SET VALUES
	_isLoggedIn = app.isLoggedIn;
	_userID = app.userID;
	_atoken = app.atoken;
	_deviceToken = app.deviceToken;
	_getuiID = app.getuiID;
	_verifyCode = app.verifyCode;
	_appType = app.appType;
	_lastLogin = app.lastLogin;
	_badgeMessage = app.badgeMessage;
	
	// CLEAN MEMORY CACHE
	app = nil;
}

// MARK: - MEMORY MANAGEMENT

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIF_USER_UPDATED object:nil];
}

// MARK: - NOTIF

- (void)userProfileUpdatedAtRemote {
	
	if (![[HAApp current] isLoggedIn]) {
		// NO NEED TO UPDATE
		return;
	}
	
	[HACore authGetUserInfoWithTokenSuccess:^(id ret) {
		NSLog(@"HAApp UserInfo Updated");
		
		NSMutableDictionary *result = [ret[@"data"] mutableCopy];
		[result setObject:_atoken forKey:@"token"];
		[self updateUserWjwLoggedIn:result];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_USER_CHANGED object:nil];
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

// MARK: - OVERRIDE

- (NSString *)description {
	return [NSString stringWithFormat:@"\n\nHAApp {\n\tUID = %@\n\tIs Login = %@\n\ttoken = %@\n\tUserID = %@\n\tLast Login = %@\n}\n\n",
			self.UID,
			_isLoggedIn ? @"Yes" : @"No",
			_atoken,
			_userID,
			_lastLogin
			];
}

@end
