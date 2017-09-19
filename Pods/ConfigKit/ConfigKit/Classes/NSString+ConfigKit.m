//
//  NSString+ConfigKit.m
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSString+ConfigKit.h"
#import "ConfigKit.h"

@implementation NSString (ConfigKit)

- (NSString *)localized {
	
	// SET DEFAULT VALUE
	if ([[NSUserDefaults standardUserDefaults] objectForKey:CONFIGKIT_LANG] == nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:CONFIGKIT_LANG];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	return [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:CONFIGKIT_LANG]] ofType:@"lproj"]] localizedStringForKey:(self) value:nil table:@"Localizable"];
}

@end
