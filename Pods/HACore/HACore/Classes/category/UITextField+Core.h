//
//  UITextField+Core.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-10.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

/**
 核心库 UI分类
 */
@interface UITextField (Core)

/**
 检查输入框是否已填值

 @return 是否已填写
 */
- (BOOL)checkIsFilled;

/**
 检查输入框已填字符串长度是否在指定长度间

 @param minlength 指定最短长度
 @param maxlength 指定最长长度
 @return 是否满足
 */
- (BOOL)checkStringLengthBetween:(NSInteger)minlength and:(NSInteger)maxlength;

@end
