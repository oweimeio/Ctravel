//
//  NSString+HACore.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-14.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSString+HACore.h"
#import <LYCategory/LYCategory.h>

@implementation NSString (HACore)

// MARK: - VALIDATION

- (BOOL)validatePhoneNumber {
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d"] evaluateWithObject:[self phoneNumber]];
}

- (BOOL)validatePhoneNumberProject {
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d"] evaluateWithObject:self];
}

- (BOOL)validatePassword {
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d|\\w"] evaluateWithObject:self];
}

- (BOOL)validateHALocation {
	return [[self componentsSeparatedByString:@","] count] == 2 && CLLocationCoordinate2DIsValid(CLLocationCoordinate2DMake([[[self componentsSeparatedByString:@","] lastObject] doubleValue], [[[self componentsSeparatedByString:@","] firstObject] doubleValue]));
}

- (CLLocationCoordinate2D)haCoordinate {
	CLLocationCoordinate2D coordinate;
	if ([self validateHALocation]) {
		coordinate = CLLocationCoordinate2DMake([[[self componentsSeparatedByString:@","] lastObject] doubleValue],
												[[[self componentsSeparatedByString:@","] firstObject] doubleValue]);
	} else {
		coordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);
	}
	return coordinate;
}

- (CLLocationCoordinate2D)haStaticCoordinate {
	CLLocationCoordinate2D coordinate;
	
	if ([self validateHALocation]) {
		coordinate = CLLocationCoordinate2DMake([[[self componentsSeparatedByString:@","] lastObject] doubleValue],
												[[[self componentsSeparatedByString:@","] firstObject] doubleValue]);
		coordinate = [CLLocation convertFromBDToGCJ02:coordinate];
	} else {
		coordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);
	}
	return coordinate;
}

@end
