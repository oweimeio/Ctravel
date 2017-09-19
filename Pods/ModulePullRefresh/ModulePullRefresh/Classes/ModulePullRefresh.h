//
//  ModulePullRefresh.h
//  MODULEPULLREFRESH
//
//  CREATED BY LUO YU ON 2016-10-12.
//  COPYRIGHT (C) 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

FOUNDATION_EXPORT NSString *const LIB_PULL_REFRESH_BUNDLE_ID;

// MARK: - ModulePullRefresh

@interface ModulePullRefresh : NSObject

/**
 读取配置文件
 
 @return 配置数据
 */
+ (NSDictionary *)readConfigurationFile;

@end

// MARK: - MJRefreshHeader

@interface MJRefreshHeader (PullRefresh)

/**
 配置下拉刷新组件样式
 */
- (void)setupAppStyle;

@end

// MARK: - MJRefreshGifHeader

@interface MJRefreshGifHeader (PullRefresh)

@end
