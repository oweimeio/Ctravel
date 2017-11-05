//
//  Experience.m
//  Ctravel
//
//  Created by apple on 2017/9/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Experience.h"
#import "PreHeader.h"

@implementation Experience

+ (instancetype)defaultExperience {
    static Experience *experience = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        experience = [[Experience alloc] init];
    });
    return experience;
}

+ (instancetype)getExperienceDataWithUID:(NSString *)UID {
    NSString *experiencefolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
    
    if (![FCFileManager isDirectoryItemAtPath:experiencefolder]) {
        [[HACore core] logInnerError:@"Experience folder not exist"];
        
        [FCFileManager createDirectoriesForPath:experiencefolder];
        return nil;
    }
    
    NSString *experiencepath = [experiencefolder stringByAppendingFormat:@"/%@.plist", UID];
    
    if (![FCFileManager isFileItemAtPath:experiencepath]) {
        [[HACore core] logInnerError:@"Experience file not exist"];
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:experiencepath];
}

+ (void)saveExperienceDataWithUID:(NSString *)UID {
    NSString *experiencefolder = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", NSStringFromClass([self class])];
    if (![FCFileManager isDirectoryItemAtPath:experiencefolder]) {
        [[HACore core] logInnerError:@"Experience folder not exist"];
        
        [FCFileManager createDirectoriesForPath:experiencefolder];
    }
    NSString *userpath = [experiencefolder stringByAppendingFormat:@"/%@.plist", UID];
    
    if (![FCFileManager isFileItemAtPath:userpath]) {
        [[HACore core] logInnerError:@"Experience file not exist"];
    }
    
    [NSKeyedArchiver archiveRootObject:[Experience defaultExperience] toFile:userpath];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.styleId = [coder decodeObjectForKey:@"self.styleId"];
        self.style = [coder decodeObjectForKey:@"self.style"];
        self.city = [coder decodeObjectForKey:@"self.city"];
        self.title = [coder decodeObjectForKey:@"self.title"];
        self.contentDes = [coder decodeObjectForKey:@"self.contentDes"];
        self.destination = [coder decodeObjectForKey:@"self.destination"];
        self.mark = [coder decodeObjectForKey:@"self.mark"];
        self.mustKnow = [coder decodeObjectForKey:@"self.mustKnow"];
        self.requirement = [coder decodeObjectForKey:@"self.requirement"];
        self.rendezvous = [coder decodeObjectForKey:@"self.rendezvous"];
        self.defaultTimeStart = [coder decodeObjectForKey:@"self.defaultTimeStart"];
        self.defaultTimeEnd = [coder decodeObjectForKey:@"self.defaultTimeEnd"];
        self.imageUrl_main = [coder decodeObjectForKey:@"self.imageUrl_main"];
        self.imageUrl_left = [coder decodeObjectForKey:@"self.imageUrl_left"];
        self.imageUrl_right = [coder decodeObjectForKey:@"self.imageUrl_right"];
        self.price = [coder decodeDoubleForKey:@"self.price"];
        self.currencyType = [coder decodeObjectForKey:@"self.currencyType"];
        self.peopleCount = [coder decodeIntegerForKey:@"self.peopleCount"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.styleId forKey:@"self.styleId"];
    [coder encodeObject:self.style forKey:@"self.style"];
    [coder encodeObject:self.city forKey:@"self.city"];
    [coder encodeObject:self.title forKey:@"self.title"];
    [coder encodeObject:self.contentDes forKey:@"self.contentDes"];
    [coder encodeObject:self.destination forKey:@"self.destination"];
    [coder encodeObject:self.mark forKey:@"self.mark"];
    [coder encodeObject:self.mustKnow forKey:@"self.mustKnow"];
    [coder encodeObject:self.requirement forKey:@"self.requirement"];
    [coder encodeObject:self.rendezvous forKey:@"self.rendezvous"];
    [coder encodeObject:self.defaultTimeStart forKey:@"self.defaultTimeStart"];
    [coder encodeObject:self.defaultTimeEnd forKey:@"self.defaultTimeEnd"];
    [coder encodeObject:self.imageUrl_main forKey:@"self.imageUrl_main"];
    [coder encodeObject:self.imageUrl_left forKey:@"self.imageUrl_left"];
    [coder encodeObject:self.imageUrl_right forKey:@"self.imageUrl_right"];
    [coder encodeDouble:self.price forKey:@"self.price"];
    [coder encodeObject:self.currencyType forKey:@"self.currencyType"];
    [coder encodeInteger:self.peopleCount forKey:@"self.peopleCount"];
}

@end
