//
//  AppDelegate.h
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreHeader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong)UITabBarController *tabs;

/**
 Current app delegate instance
 
 @return self
 */
+ (AppDelegate *)app;

/**
 切换应用视图
 
 @param atype 应用类型
 */
- (void)switchAppType:(AppType)atype;

@end

