//
//  UITextField+Core.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-10.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "UITextField+Core.h"
#import "HACore.h"

@implementation UITextField (Core)

- (BOOL)checkIsFilled {
	
	if (self.text == nil || [self.text isEqualToString:@""]) {
		[[HACore core] logInnerError:@"TextField has empty string"];
		return NO;
	}
	
	return YES;
}

- (BOOL)checkStringLengthBetween:(NSInteger)minlength and:(NSInteger)maxlength {
	
	if (self.text.length < minlength) {
		[[HACore core] logInnerError:@"TextField less than min length"];
		return NO;
	} else if (self.text.length > maxlength) {
		[[HACore core] logInnerError:@"TextField larger than max length"];
		return NO;
	}
	
	return YES;
}

@end
