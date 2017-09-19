//
//  NSString+Validation.m
//  ygwjw
//
//  Created by Luo Yu on 8/4/16.
//  Copyright © 2016 Huaao Tech. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isNumber {
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d"] evaluateWithObject:self];
}

- (BOOL)isNumberAndChar {
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d|\\w"] evaluateWithObject:self];
}

- (BOOL)isTelphoneNum {
	NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|4[57]|7[06-8])\\d{8}$";
	NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
	NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
	NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
	NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
	NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
	NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
	NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
	
	return [regextestmobile evaluateWithObject:self] ||
	[regextestphs evaluateWithObject:self] ||
	[regextestct evaluateWithObject:self] ||
	[regextestcu evaluateWithObject:self] ||
	[regextestcm evaluateWithObject:self];
}

- (BOOL)isMapLenOFWords {
	//^[\u4E00-\u9FA5]{2,4}$
	NSString * regex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5_a-zA-Z0-9]+$"];
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isMapLenOFWordsMinLen:(int)minLen maxLen:(int)maxLen {
	NSString * regex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5_a-zA-Z0-9]{%d,%d}$", minLen, maxLen];
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isSecretWordsMinLen:(int)minLen maxLen:(int)maxLen {
    NSString * regex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%d,%d}$", minLen, maxLen];
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}
- (BOOL)isUserName {
	NSString * regex = [NSString stringWithFormat:@"^[a-zA-Z•·\u4e00-\u9fa5]{2,10}$"];
	return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)stringContainsEmoji
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}


@end
