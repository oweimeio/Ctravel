//
//  NSNumber+HACore.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-24.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSNumber+HACore.h"
#import <LYCategory/LYCategory.h>
#import "HACoreConst.h"

@implementation NSNumber (HACore)

- (NSString *)stringInHAFromDateFormat:(NSString *)fmtstring {
	
	double selfvalue = 0.0f;
	
	if ([[NSString stringWithFormat:@"%@", self] length] > 12) {
		// M-SECOND
		selfvalue = [self doubleValue] / 1000.0f;
	} else {
		selfvalue = [self doubleValue];
	}
	
	return [[NSDate dateWithTimeIntervalSince1970:selfvalue] stringWithFormat:fmtstring andTimezone:SHANGHAI];
}

@end

@implementation NSString (HACoreNumberFix)

- (NSString *)stringInHAFromDateFormat:(NSString *)fmtstring {
	
	if ([self containsString:@"-"] ||
		[self containsString:@"年"] ||
		[self containsString:@"月"] ||
		[self containsString:@"日"] ) {
		return self;
	}
	
	double selfvalue = 0.0f;
	
	if ([self length] > 12) {
		selfvalue = [self doubleValue] / 1000.0f;
	} else {
		selfvalue = [self doubleValue];
	}
	
	return [[NSDate dateWithTimeIntervalSince1970:selfvalue] stringWithFormat:fmtstring andTimezone:SHANGHAI];
}

@end
