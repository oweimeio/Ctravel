//
//  Experience.m
//  Ctravel
//
//  Created by apple on 2017/9/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Experience.h"

@implementation Experience

+ (instancetype)defaultExperience {
    static Experience *experience = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        experience = [[Experience alloc] init];
    });
    return experience;
}

@end
