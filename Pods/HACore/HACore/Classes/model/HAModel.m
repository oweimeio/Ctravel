//
//  HAModel.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAModel.h"
#import "HACore.h"
#import "FCFileManager.h"

@interface HAModel ()

@end

@implementation HAModel

// MARK: - METHOD 公有方法

- (void)persist {
	
	NSString *modeldir = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
	
	if (![FCFileManager isDirectoryItemAtPath:modeldir]) {
		// DIRECTORY NOT EXIST
		// THEN
		// CREATE
		[FCFileManager createDirectoriesForPath:modeldir];
	}
	
	if (_UID == nil || [_UID isEqualToString:@""]) {
		[[HACore core] logInnerError:@"MODEL <%@> UID => nil", NSStringFromClass([self class])];
		return;
	}
	
	NSString *modelpath = [modeldir stringByAppendingFormat:@"/%@", _UID];
	
	if ([FCFileManager isFileItemAtPath:modelpath]) {
		// FILE EXIST
		// THEN
		// DELETE
		[FCFileManager removeItemAtPath:modelpath];
	}
	
	// ADD FILE
	BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:modelpath];
	[[HACore core] logInnerWarning:@"WRITE(%@) %@\n%@",
									 NSStringFromClass([self class]),
									 result ? @"SUCCESS" : @"FAILED",
									 self];
}

// MARK: PRIVATE METHOD

// MARK: - OVERRIDE

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.UID = [coder decodeObjectForKey:@"self.UID"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.UID forKey:@"self.UID"];
}

- (id)copyWithZone:(NSZone *)zone {
	HAModel *copy = (HAModel *)[[[self class] allocWithZone:zone] init];

	if (copy != nil) {
		copy.UID = self.UID;
	}

	return copy;
}


@end
