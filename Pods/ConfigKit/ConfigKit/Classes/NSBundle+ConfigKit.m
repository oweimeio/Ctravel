//
//  NSBundle+ConfigKit.m
//  ConfigKit
//
//  CREATED BY LUO YU ON 2017-01-01.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSBundle+ConfigKit.h"

@implementation NSBundle (ConfigKit)

+ (instancetype)bundleNamed:(NSString *)bundleName {
	return [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[bundleName stringByAppendingString:@".bundle"]]];
}

@end
