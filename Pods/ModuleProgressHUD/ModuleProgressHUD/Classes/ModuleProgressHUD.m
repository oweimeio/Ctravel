//
//  ModuleProgressHUD.m
//  LUO YU
//
//  CREATED BY LUO Yu ON 2013-07-23.
//  COPYRIGHT (C) 2013 LUO YU. ALL RIGHTS RESERVED.
//

#import "ModuleProgressHUD.h"
#import "FCFileManager.h"

NSString *const LIB_PROGRESSHUD_BUNDLE_ID = @"org.cocoapods.ModuleProgressHUD";
NSString *const NAME_CONF_PROGRESS_HUD = @"conf-progress-hud"; // SHOUND NOT BE CHANGED

@implementation ModuleProgressHUD
	
+ (void)autoConfigure {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_PROGRESS_HUD ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		
		NSLog(@"ModuleProgressHUD WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_PROGRESSHUD_BUNDLE_ID] pathForResource:NAME_CONF_PROGRESS_HUD ofType:@"plist"];
	}
	
	// TRY TO READ APP CONFIGURATION
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"ModuleProgressHUD ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	// NSLog(@"%@", conf);
	
	// CONFIGURE HUD STYLE
	[SVProgressHUD setDefaultStyle:[conf[@"sv-default-style"][@"conf-value"] integerValue]];
	[SVProgressHUD setDefaultMaskType:[conf[@"sv-default-mask-type"][@"conf-value"] integerValue]];
	[SVProgressHUD setMinimumDismissTimeInterval:[conf[@"sv-default-min-dismiss-interval"][@"conf-value"] doubleValue]];
}
	
@end

@implementation SVProgressHUD (Additions)
	
// SHOW ERROR STATUS WITH A STRING USING C PRINTF-STYLE FORMATTING
+ (void)showErrorWithFormatStatus:(NSString *)format, ... {
	
	va_list args;
	id ret;
	
	va_start(args, format);
	if (format == nil) {
		ret = nil;
	} else {
		ret = [[NSString alloc] initWithFormat:format arguments:args];
	}
	
	va_end(args);
	
	if (ret != nil) {
		[SVProgressHUD showErrorWithStatus:ret];
	} else {
		[SVProgressHUD showErrorWithStatus:@""];
	}
}
	
// SHOW SUCCESS STATUS WITH A STRING USING C PRINTG-STYLE FORMATTING
+ (void)showSuccessWithFormatStatus:(NSString *)format, ... {
	
	va_list args;
	id ret;
	
	va_start(args, format);
	if (format == nil) {
		ret = nil;
	} else {
		ret = [[NSString alloc] initWithFormat:format arguments:args];
	}
	
	va_end(args);
	
	if (ret != nil) {
		[SVProgressHUD showSuccessWithStatus:ret];
	} else {
		[SVProgressHUD showSuccessWithStatus:@""];
	}
	
}
	
// SHOW HUD WHEN IT'S VISIBLE
+ (void)tryToShowErrorWithFormatStatus:(NSString *)format, ... {
	
	va_list args;
	id ret;
	
	va_start(args, format);
	if (format == nil) {
		ret = nil;
	} else {
		ret = [[NSString alloc] initWithFormat:format arguments:args];
	}
	
	va_end(args);
	
	if (ret != nil && [SVProgressHUD isVisible]) {
		[SVProgressHUD showErrorWithStatus:ret];
	} else if ([SVProgressHUD isVisible]) {
		[SVProgressHUD showErrorWithStatus:@""];
	} else {
		// DO NOTHING
	}
	
}
	
+ (void)showMessage:(NSString *)message withDelay:(NSInteger)seconds {
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[SVProgressHUD showImage:nil status:message];
	});
}

+ (void)showProgressHideAfter:(NSInteger)seconds {
	[SVProgressHUD show];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[SVProgressHUD dismiss];
	});
}
	
@end
