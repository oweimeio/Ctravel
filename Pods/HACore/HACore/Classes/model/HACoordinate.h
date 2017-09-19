//
//  HACoordinate.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-08.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <HACore/HACoreHeader.h>
#import <CoreLocation/CoreLocation.h>

@interface HACoordinate : HAModel <NSCopying, NSCoding>

/**
 纬度
 */
@property (nonatomic, assign) double latitude;

/**
 经度
 */
@property (nonatomic, assign) double longitude;

/**
 坐标(只读)
 */
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

/**
 字符串坐标参数(只读)
 */
@property (nonatomic, readonly, strong) NSString *param;

/**
 通过经纬度创建坐标对象

 @param latitude 纬度值
 @param longitude 经度值
 @return 坐标对象实例
 */
+ (instancetype)coordinateWithLatitude:(double)latitude andLongitude:(double)longitude;

/**
 通过WGS84坐标创建坐标对象

 @param wgs84Coordinate WGS84坐标
 @return 坐标对象实例
 */
+ (instancetype)coordinateWithWGS84:(CLLocationCoordinate2D)wgs84Coordinate;

/**
 通过Server坐标字符串创建坐标对象

 @param coordinateHAString Server给的坐标字符串
 @return 坐标对象实例
 */
+ (instancetype)coordinateWithHAString:(NSString *)coordinateHAString;

@end
