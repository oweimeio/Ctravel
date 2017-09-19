//
//  HAModel.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-16.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>

/**
 华奥模型基类.
 HuaaoTech root model class.
 @warnings 应作为所有模型类的根类
 */
@interface HAModel : NSObject <NSCoding, NSCopying>

/**
 模型类 唯一标识符.
 Unique ID.
 */
@property (nonatomic, strong) NSString *UID;

/**
 Persist Model.
 
 持久化模型类
 */
- (void)persist;

@end
