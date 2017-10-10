//
//  AppDelegate.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    __strong UITabBarController *tabs;
}

@end

@implementation AppDelegate

/**
 Current app delegate instance
 
 @return self
 */
+ (AppDelegate *)app {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

/**
 切换应用状态
 
 @param atype AppType应用状态
 */
- (void)switchAppType:(AppType)atype {
    
    // STOP SERVER UPDATING
    
//    {
//        // MARK: 应用导向处理
//        if (atype == AppTypePolice && [[HAUserWjw userWithUID:[HAApp current].userID] hasOperationPrivilege] == NO) {
//            atype = AppTypeResident;
//        }
//        
//        if ([[HAApp current] isLoggedIn] == NO) {
//            atype = AppTypeLogin;
//        }
//    }
	
    switch (atype) {
        case AppTypeResident: {
            
            self.window.rootViewController = nil;
            tabs = nil;
            tabs = [[UITabBarController alloc] init];
            
            UINavigationController *cMain = [[UINavigationController alloc] initWithRootViewController:[[ClientMainPageViewController alloc] init]];
            cMain.tabBarItem.title = @"主页";
            cMain.tabBarItem.image = [UIImage imageNamed:@"tab-find-gray"];
            cMain.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-job-blue"];
            
            FavoriteViewController *favVc = [[FavoriteViewController alloc] init];
            favVc.hideNavBar = YES;
            UINavigationController *cFov = [[UINavigationController alloc] initWithRootViewController:favVc];
            cFov.tabBarItem.title =@"收藏";
            cFov.tabBarItem.image = [UIImage imageNamed:@"tab-fav-gray"];
            cFov.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-fav-blue"];
            
            
            UINavigationController *cMsg = [[UINavigationController alloc] initWithRootViewController:[ClientMsgViewController new]];
            cMsg.title = @"消息";
            cMsg.tabBarItem.image = [UIImage imageNamed:@"tab-msg-gray"];
            cMsg.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-msg-blue"];
            
            UINavigationController *cOrder = [[UINavigationController alloc] initWithRootViewController:[[ClientOrderViewController alloc] init]];
            cOrder.navigationBar.translucent = NO;
            cOrder.tabBarItem.title =@"预订";
            cOrder.tabBarItem.image = [UIImage imageNamed:@"tab-cOrder-gray"];
            cOrder.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-cOrder-blue"];
            
            UINavigationController *cProfile = [[UINavigationController alloc] initWithRootViewController:[ClientProfileViewController new]];
            cProfile.tabBarItem.title = @"我的";
            cProfile.tabBarItem.image = [UIImage imageNamed:@"tab-me-gray"];
            cProfile.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-me-blue"];
            
            tabs.viewControllers = @[cMain, cFov, cMsg, cOrder, cProfile];
            self.window.rootViewController = tabs;
            [HAApp current].appType = AppTypeResident;
            
        } break;
        case AppTypePolice: {
            
            self.window.rootViewController = nil;
            
            tabs = nil;
            
            tabs = [[UITabBarController alloc] init];
            
            UINavigationController *sMain = [[UINavigationController alloc] initWithRootViewController:[[ServerMainViewController alloc] init]];
            sMain.tabBarItem.title = @"主页";
            sMain.tabBarItem.image = [UIImage imageNamed:@"tab-ex-gray"];
            sMain.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-ex-blue"];
            
            DateViewController *dateVc = [[DateViewController alloc] init];
            dateVc.hideNavBar = YES;
            UINavigationController *sDate = [[UINavigationController alloc] initWithRootViewController:dateVc];
            sDate.tabBarItem.title =@"日期";
            sDate.tabBarItem.image = [UIImage imageNamed:@"tab-date-gray"];
            sDate.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-date-blue"];
            
            
            UINavigationController *sMsg = [[UINavigationController alloc] initWithRootViewController:[ServerMessageViewController new]];
            sMsg.title = @"消息";
            sMsg.tabBarItem.image = [UIImage imageNamed:@"tab-msg-gray"];
            sMsg.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-msg-blue"];
            
            UINavigationController *sOrder = [[UINavigationController alloc] initWithRootViewController:[[ServerOrderViewController alloc] init]];
            sOrder.navigationBar.translucent = NO;
            sOrder.tabBarItem.title =@"订单";
            sOrder.tabBarItem.image = [UIImage imageNamed:@"tab-order-gray"];
            sOrder.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-order-blue"];
            
            UINavigationController *sProfile = [[UINavigationController alloc] initWithRootViewController:[ServerProfileViewController new]];
            sProfile.tabBarItem.title = @"我的";
            sProfile.tabBarItem.image = [UIImage imageNamed:@"tab-me-gray"];
            sProfile.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-me-blue"];
            
            tabs.viewControllers = @[sMain, sDate, sMsg, sOrder, sProfile];
            
            self.window.rootViewController = tabs;
            [HAApp current].appType = AppTypePolice;
            
        } break;
        case AppTypeLogin:
        default: {
            // 类型 -> 登录模式
            
            self.window.rootViewController = nil;
            tabs = nil;
 
            UINavigationController *preauthNav = [[UINavigationController alloc] initWithRootViewController:[LoginChooseViewController new]];
            self.window.rootViewController = preauthNav;
            [HAApp current].appType = AppTypeLogin;
            
        } break;
    }
}


// MARK: Guide

- (void)startSelectViewController {
    //1.第一次启动程序时和版本升级时  加载引导页
    
    //2.先获取当前app的版本号
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    //3.读取本地存储的版本号
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * saveVersion = [userDefaults objectForKey:@"AppVersion"];
    
    //4.比对版本号
    //版本号一致
    if ([currentVersion isEqualToString:saveVersion]) {
        [self switchAppType:[HAApp current].appType];
        
        
    } else {
        //加载引导页
        LoginChooseViewController *gudideVC = [[LoginChooseViewController alloc] init];
        
        self.window.rootViewController = gudideVC;
        
        //再去存储当前app的版本号
        
        [userDefaults setObject:currentVersion forKey:@"AppVersion"];
    }
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"\n\nENTER\n\t-application:didFinishLaunchingWithOptions:\n\n");
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([[HAApp current] isLoggedIn]) {
        [self switchAppType:[[HAUserWjw userWithUID:[HAApp current].userID] hasOperationPrivilege] ? AppTypePolice : AppTypeResident];
    } else {
        [self switchAppType:AppTypeLogin];
    }
    
    [_window makeKeyAndVisible];
    
    // MARK: STYLE
    [[ConfigKit kit] systemStyle];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    [ModuleProgressHUD autoConfigure];
    
    [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
    [[AFNetworkReachabilityManager sharedManager] isReachable];
    
    [self startSelectViewController];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
