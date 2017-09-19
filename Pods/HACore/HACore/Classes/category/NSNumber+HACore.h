//
//  NSNumber+HACore.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-24.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>

@interface NSNumber (HACore)

/**
 core lib time interval to readable string with date formatter

 @param fmtstring formatter
 @return string result
 */
- (NSString *)stringInHAFromDateFormat:(NSString *)fmtstring;

@end

@interface NSString (HACoreNumberFix)

- (NSString *)stringInHAFromDateFormat:(NSString *)fmtstring;

@end
