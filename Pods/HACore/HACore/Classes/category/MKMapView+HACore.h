//
//  MKMapView+HACore.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-05-03.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (HACore)


/**
 移动地图视角至坐标点集合

 @param annotations 坐标点集合
 */
- (void)focusOnRegionWithAnnotations:(NSArray *)annotations;

/**
 移动地图视角至用户辖区

 @param coordinates 辖区坐标字符串集合
 */
- (void)focusOnUserCommunityArea:(NSArray *)coordinates;

/**
 移动地图视角至用户辖区

 @param listOfPoints 辖区坐标字符串集合
 @param staticOrNot 是否启用BD坐标系转换
 */
- (void)focusOnUserCommunityArea:(NSArray *)listOfPoints isStatic:(BOOL)staticOrNot;

/**
 移动地图视角到指定坐标, 并且根据指定点计算span
 默认启用BD坐标系转换

 @param centerCoor 中心坐标
 @param coordinates 指定点集合
 */
- (void)focusOnCenter:(CLLocationCoordinate2D)centerCoor andRegionSpanWithCoordinates:(NSArray *)coordinates;


/**
 移动地图视角到指定坐标, 并且根据指定点计算span

 @param centerCoor 中心坐标
 @param listOfPois 指定点集合
 @param staticOrNot 是否启用BD坐标系转换
 */
- (void)focusOnCenter:(CLLocationCoordinate2D)centerCoor andRegionSpanWithCoordinates:(NSArray *)listOfPois isStatic:(BOOL)staticOrNot;

@end
