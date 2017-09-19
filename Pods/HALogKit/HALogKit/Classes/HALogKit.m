//
//  HALogKit.m
//  HALogKit
//
//  CREATED BY LUO YU ON 2016-12-28.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "HALogKit.h"
#import <CoreLocation/CoreLocation.h>

@interface HALogKit () <CLLocationManagerDelegate> {
	CLLocationManager *locmgr;
	
	NSDate *target;
	NSTimer *repeat;
	
	CLLocationCoordinate2D tempCoor;
}
@end

@implementation HALogKit

#pragma mark - INIT

+ (instancetype)kit {
	static HALogKit *sharedLogKit;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedLogKit = [[HALogKit alloc] init];
	});
	
	return sharedLogKit;
}

- (instancetype)init {
	if (self = [super init]) {
		locmgr = [[CLLocationManager alloc] init];
		locmgr.desiredAccuracy = kCLLocationAccuracyBest;
		locmgr.delegate = self;
		
		_per = 5;
	}
	return self;
}

- (void)setPer:(NSInteger)per {
	_per = per;
	
	if (_per <= 0) {
		_per = 5;
	}
}

#pragma mark - METHOD

- (void)startLocating {
	
	if ([CLLocationManager locationServicesEnabled] == NO) {
		NSLog(@"LOCATION NOT ENABLE");
	} else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
		NSLog(@"");
		[locmgr requestWhenInUseAuthorization];
	}
	
	[locmgr startUpdatingLocation];
	
	_updating = YES;
	_updated = NO;
	
	target = [NSDate dateWithTimeIntervalSinceNow:_per];
	
	[repeat invalidate];
	repeat = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduledChecker:) userInfo:nil repeats:YES];
}

- (void)stopLocating {
	[locmgr stopUpdatingLocation];
	[repeat invalidate];
	repeat = nil;
	target = nil;
	
	_updating = NO;
}

- (void)startLocatingOnce {
	
	if ([CLLocationManager locationServicesEnabled] == NO) {
		NSLog(@"LOCATION NOT ENABLE");
	} else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
		NSLog(@"");
		[locmgr requestWhenInUseAuthorization];
	}
	
	[locmgr startUpdatingLocation];
	
	_updating = YES;
	_updated = NO;
	
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduledOnceChecker:)
								   userInfo:nil repeats:YES];
}

- (void)scheduledChecker:(NSTimer *)timer {
	NSTimeInterval left = [target timeIntervalSinceDate:[NSDate date]];
	if (left > 0) {
		// NOT NOW
	} else {
		// GET COORDINATE
		_current = tempCoor;
		target = [NSDate dateWithTimeIntervalSinceNow:_per];
		//_updated = YES;
	}
}

- (void)scheduledOnceChecker:(NSTimer *)timer {
	if (tempCoor.latitude != 0 && tempCoor.longitude != 0) {
		_current = tempCoor;
		[timer invalidate];
		[locmgr stopUpdatingLocation];
		_updating = NO;
		//_updated = YES;
	}
}

// MARK: PERMISSION

- (void)askWhenInUsePermission {
	if ([CLLocationManager locationServicesEnabled] == NO) {
		NSLog(@"LOCATION NOT ENABLE");
	} else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
		NSLog(@"");
		[locmgr requestWhenInUseAuthorization];
	}
}

#pragma mark - DELEGATE

#pragma mark | CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	__weak CLLocation *location = locations.firstObject;
	tempCoor = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
	
	_updated = YES;
}


@end
