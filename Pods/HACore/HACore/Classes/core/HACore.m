//
//  HACore.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-04.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore.h"
#import "FCFileManager.h"
#import "HACoreAPI.h"
#import "HAConstHeader.h"
#import "HAApp.h"
#import "HAUserWjw.h"

NSString *const LIB_HACONF_BUNDLE_ID = @"org.cocoapods.HACore";
NSString *const NAME_CONF_HA_CORE = @"com.huaaotech.core.conf";

/**
 核心库 匿名分类
 */
@interface HACore () {}
@end

@implementation HACore

// MARK: -

- (instancetype)init {
	if (self = [super init]) {
	}
	return self;
}

+ (instancetype)core {
	static HACore *sharedCore;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedCore = [[HACore alloc] init];
	});
	return sharedCore;
}

// MARK: - PROPERTY

- (void)setDebug:(BOOL)debug {
	_debug = debug;
	
	[HACoreAPI core].debug = _debug;
}

// MARK: - CONF

- (NSDictionary *)conf {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_HA_CORE ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		
		NSLog(@"HACore WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_HACONF_BUNDLE_ID] pathForResource:NAME_CONF_HA_CORE ofType:@"plist"];
	}
	
	// TRY TO READ APP CONFIGURATION
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"HACore ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	return conf;
}

- (id)valueForConfWithKey:(NSString *)keys {
	
	// IF
	if (keys == nil || [keys isEqualToString:@""] || [keys isKindOfClass:[NSString class]] == NO) {
		return nil;
	}
	
	// GET VALUE
	return [self conf][keys][@"conf-value"];
}

// MARK: - TOOL

- (NSString *)logInnerError:(NSString *)format, ... {
	
	va_list args;
	id ret;
	
	va_start(args, format);
	if (format == nil) {
		ret = nil;
	} else {
		format = [format stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
		ret = [[NSString alloc] initWithFormat:format arguments:args];
	}
	
	va_end(args);
	
	if (ret != nil) {
		
		NSLog(@"\n\nHaCore ERROR :\n\t%@", ret);
		
		return [NSString stringWithFormat:@"\n\n%@\nHaCore ERROR :\n\t%@",
				[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI], ret];
	} else {
		// NIL
		NSLog(@"\n\nHaCore ERROR :\n\t");
	}
	
	return [NSString stringWithFormat:@"\n\n%@\nHaCore ERROR :\n\tNO LOG", [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI]];
}

- (NSString *)logInnerWarning:(NSString *)format, ... {
	
	va_list args;
	id ret;
	
	va_start(args, format);
	if (format == nil) {
		ret = nil;
	} else {
		format = [format stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
		ret = [[NSString alloc] initWithFormat:format arguments:args];
	}
	
	va_end(args);
	
	if (ret != nil) {
		
		NSLog(@"\n\nHaCore WARNING :\n\t%@", ret);
		
		return [NSString stringWithFormat:@"\n\n%@\nHaCore WARNING :\n\t%@",
				[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI], ret];
	} else {
		// NIL
		NSLog(@"\n\nHaCore WARNING :\n\t");
	}
	
	return [NSString stringWithFormat:@"\n\n%@\nHaCore WARNING :\n\tNO LOG", [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI]];
	
}

@end
