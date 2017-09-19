//
//  MKMapView+HACore.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-05-03.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "MKMapView+HACore.h"
#import "NSString+HACore.h"

@implementation MKMapView (HACore)

- (void)focusOnRegionWithAnnotations:(NSArray *)annotations {
	
	if ([annotations count] <= 0) {
		return;
	}
	
	CLLocationCoordinate2D origin = [((MKPointAnnotation *)[annotations firstObject]) coordinate];
	CLLocationCoordinate2D fast = [((MKPointAnnotation *)[annotations firstObject]) coordinate];
	
	for (MKPointAnnotation *annotation in annotations) {
		
		origin.latitude = MIN(annotation.coordinate.latitude, origin.latitude);
		origin.longitude = MIN(annotation.coordinate.longitude, origin.longitude);
		
		fast.latitude = MAX(annotation.coordinate.latitude, fast.latitude);
		fast.longitude = MAX(annotation.coordinate.longitude, fast.longitude);
	}
	
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake((origin.latitude + fast.latitude) / 2, (origin.longitude + fast.longitude) / 2);
	
	MKCoordinateSpan span = MKCoordinateSpanMake((fast.latitude - origin.latitude) + 0.001, (fast.longitude - origin.longitude) + 0.001);
	
	/*
	NSLog(@"\n\nFOCUS ON REGION\n\tORIGIN\n\t\tLATITUDE=%@\n\t\tLONGTITUDE=%@\n\tFAST\n\t\tLATITUDE=%@\n\t\tLONGITUDE=%@\n\tCENTER\n\t\tLATITUDE=%@\n\t\tLONGITUDE=%@\n\tSPAN\n\t\tlatitudeDelta=%@\n\t\tlongitudeDelta=%@\n\n ",
		  @(origin.latitude), @(origin.longitude),
		  @(fast.latitude), @(fast.longitude),
		  @(center.latitude), @(center.longitude),
		  @(span.latitudeDelta), @(span.longitudeDelta));
	*/
	
	[self setRegion:MKCoordinateRegionMake(center, span) animated:YES];
}

- (void)focusOnUserCommunityArea:(NSArray *)listOfPoints {
	[self focusOnUserCommunityArea:listOfPoints isStatic:YES];
}

- (void)focusOnUserCommunityArea:(NSArray *)listOfPoints isStatic:(BOOL)staticOrNot {
	
	CLLocationCoordinate2D coordinates[[listOfPoints count]];
	
	for (int i = 0; i < [listOfPoints count]; i++) {
		if (staticOrNot) {
			coordinates[i] = [listOfPoints[i] haStaticCoordinate]; // BD-MARS
		} else {
			coordinates[i] = [listOfPoints[i] haCoordinate]; // CONVERTED
		}
	}
	
	// SET REGION
	CLLocationCoordinate2D areaMin;
	CLLocationCoordinate2D areaMax;
	
	for (int i = 0; i < [listOfPoints count]; i++) {
		areaMax.latitude = MAX(areaMax.latitude, coordinates[i].latitude);
		areaMax.longitude = MAX(areaMax.longitude, coordinates[i].longitude);
		
		areaMin.latitude = areaMin.latitude > 0.01 ? MIN(areaMin.latitude, coordinates[i].latitude) : coordinates[i].latitude;
		areaMin.longitude = areaMin.longitude > 0.01 ? MIN(areaMin.longitude, coordinates[i].longitude) : coordinates[i].longitude;
	}
	
	
	{
		CGFloat delta = 0.2f;
		
		CGFloat maxlat;
		CGFloat maxlon;
		CGFloat minlat;
		CGFloat minlon;
		
		maxlon = areaMax.longitude + ((areaMax.longitude - areaMin.longitude) * delta);
		maxlat = areaMax.latitude + ((areaMax.latitude - areaMin.latitude) * delta);
		
		minlon = areaMin.longitude - ((areaMax.longitude - areaMin.longitude) * delta);
		minlat = areaMin.latitude - ((areaMax.latitude - areaMin.latitude) * delta);
		
		areaMax.longitude = maxlon;
		areaMax.latitude = maxlat;
		areaMin.longitude = minlon;
		areaMin.latitude = minlat;
	}
	
	CLLocationCoordinate2D areaCenter = CLLocationCoordinate2DMake((areaMin.latitude + areaMax.latitude) / 2,
																   (areaMin.longitude + areaMax.longitude) / 2);
	if (CLLocationCoordinate2DIsValid(areaCenter) == NO) {
		// CENTER COORDINATE IS INVALID
		NSLog(@"%s CENTER COORDINATE INVALID", __func__);
		return;
	}
	
	MKCoordinateSpan areaSpan = MKCoordinateSpanMake((areaMax.latitude - areaCenter.latitude) * 2,
													 (areaMax.longitude - areaCenter.longitude) * 2);
	
	// PADDING SPACE
	// CALCULATED FROM REGION RECT
	[self setRegion:MKCoordinateRegionMake(areaCenter, areaSpan) animated:YES];
}

- (void)focusOnCenter:(CLLocationCoordinate2D)centerCoor andRegionSpanWithCoordinates:(NSArray *)listOfPois {
	[self focusOnCenter:centerCoor andRegionSpanWithCoordinates:listOfPois isStatic:YES];
}

- (void)focusOnCenter:(CLLocationCoordinate2D)centerCoor andRegionSpanWithCoordinates:(NSArray *)listOfPois isStatic:(BOOL)staticOrNot {
	
	CLLocationCoordinate2D coordinates[[listOfPois count]];
	
	for (int i = 0; i < [listOfPois count]; i++) {
		if (staticOrNot) {
			coordinates[i] = [listOfPois[i] haStaticCoordinate];
		} else {
			coordinates[i] = [listOfPois[i] haCoordinate];
		}
	}
	
	CLLocationCoordinate2D areaMin;
	CLLocationCoordinate2D areaMax;
	
	for (int i = 0; i < [listOfPois count]; i++) {
		areaMax.latitude = MAX(areaMax.latitude, coordinates[i].latitude);
		areaMax.longitude = MAX(areaMax.longitude, coordinates[i].longitude);
		
		areaMin.latitude = areaMin.latitude > 0.01 ? MIN(areaMin.latitude, coordinates[i].latitude) : coordinates[i].latitude;
		areaMin.longitude = areaMin.longitude > 0.01 ? MIN(areaMin.longitude, coordinates[i].longitude) : coordinates[i].longitude;
	}
	
	{
		CGFloat delta = 0.2f;
		
		CGFloat maxlat;
		CGFloat maxlon;
		CGFloat minlat;
		CGFloat minlon;
		
		maxlon = areaMax.longitude + ((areaMax.longitude - areaMin.longitude) * delta);
		maxlat = areaMax.latitude + ((areaMax.latitude - areaMin.latitude) * delta);
		
		minlon = areaMin.longitude - ((areaMax.longitude - areaMin.longitude) * delta);
		minlat = areaMin.latitude - ((areaMax.latitude - areaMin.latitude) * delta);
		
		areaMax.longitude = maxlon;
		areaMax.latitude = maxlat;
		areaMin.longitude = minlon;
		areaMin.latitude = minlat;
	}
	
	[self setRegion:MKCoordinateRegionMake(centerCoor,
										   MKCoordinateSpanMake((areaMax.latitude - centerCoor.latitude) * 2,
																(areaMax.longitude - centerCoor.longitude) * 2))
		   animated:YES];
}

@end
