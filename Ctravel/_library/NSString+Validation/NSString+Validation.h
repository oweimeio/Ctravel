//
//  NSString+Validation.h
//  ygwjw
//
//  Created by Luo Yu on 8/4/16.
//  Copyright © 2016 Huaao Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isNumber;

- (BOOL)isNumberAndChar;

- (BOOL)isTelphoneNum; //电话号码

- (BOOL)isMapLenOFWords;

- (BOOL)isMapLenOFWordsMinLen:(int)minLen maxLen:(int)maxLen; //判断字符(汉字)长度，最小－最大长度

- (BOOL)isSecretWordsMinLen:(int)minLen maxLen:(int)maxLen;
- (BOOL)isUserName; //姓名

/**
 判断字符串中是否含有表情

 @return 是否含有表情
 */
- (BOOL)stringContainsEmoji;

@end
