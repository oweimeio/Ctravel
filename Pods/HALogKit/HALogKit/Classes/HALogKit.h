//
//  HALogKit.h
//  HALogKit
//
//  CREATED BY LUO YU ON 2016-12-28.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface HALogKit : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D current;
@property (nonatomic, assign) NSInteger per; // MINUTE

@property (nonatomic, assign) BOOL updating;

@property (nonatomic, assign) BOOL updated;

+ (instancetype)kit;

// MARK: LOCATING

- (void)startLocating;
- (void)stopLocating;

- (void)startLocatingOnce;

// MARK: PERMISSION

- (void)askWhenInUsePermission;

@end
