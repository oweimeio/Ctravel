//
//  HACoreData.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-17.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACoreData.h"

@implementation HACoreData

// MARK: - INIT

/**
 初始化方法

 @return 实例
 */
- (instancetype)init {
	if (self = [super init]) {
	}
	return self;
}

+ (instancetype)core {
	static HACoreData *sharedHACoreData;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedHACoreData = [[HACoreData alloc] init];
	});
	return sharedHACoreData;
}

// MARK: -

@end
