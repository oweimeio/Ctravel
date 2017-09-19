//
//  HACore+Device.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-24.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACore.h>

@class HACoordinate;

@interface HACore (Device)

- (BOOL)isCameraAuthorized;

- (BOOL)isPhotoLibraryAuthorized;

- (void)submitWorkerCoordinate:(HACoordinate *)coordinate;

@end
