//
//  HACoordinate.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-08.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACoordinate.h"
#import <LYCategory/LYCategory.h>

@implementation HACoordinate

- (id)copyWithZone:(NSZone *)zone {
	HACoordinate *copy = [[[self class] allocWithZone:zone] init];

	if (copy != nil) {
		copy.latitude = self.latitude;
		copy.longitude = self.longitude;
	}

	return copy;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		self.latitude = [coder decodeDoubleForKey:@"self.latitude"];
		self.longitude = [coder decodeDoubleForKey:@"self.longitude"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	[coder encodeDouble:self.latitude forKey:@"self.latitude"];
	[coder encodeDouble:self.longitude forKey:@"self.longitude"];
}

+ (instancetype)coordinateWithLatitude:(double)latitude andLongitude:(double)longitude {
	HACoordinate *coordinate = [[HACoordinate alloc] init];
	coordinate.latitude = latitude;
	coordinate.longitude = longitude;
	return coordinate;
}

+ (instancetype)coordinateWithWGS84:(CLLocationCoordinate2D)wgs84Coordinate {
	HACoordinate *coordinate = [[HACoordinate alloc] init];
	coordinate.latitude = [CLLocation convertFromWGS84ToGCJ02:wgs84Coordinate].latitude;
	coordinate.longitude = [CLLocation convertFromWGS84ToGCJ02:wgs84Coordinate].longitude;
	return coordinate;
}

+ (instancetype)coordinateWithHAString:(NSString *)coordinateHAString {
	
	if (coordinateHAString == nil ||
		[coordinateHAString isKindOfClass:[NSString class]] ||
		[coordinateHAString containsString:@","] == NO ||
		[[coordinateHAString componentsSeparatedByString:@","] count] != 2) {
		// NOT A VALID STRING
		return nil;
	}
	
	CLLocationCoordinate2D convertedCoor = CLLocationCoordinate2DMake([[[coordinateHAString componentsSeparatedByString:@","] lastObject] doubleValue], [[[coordinateHAString componentsSeparatedByString:@","] firstObject] doubleValue]);
	
	if (CLLocationCoordinate2DIsValid(convertedCoor) == NO) {
		// NOT VALID COORDINATE
		return nil;
	}
	
	HACoordinate *coordinate = [[HACoordinate alloc] init];
	coordinate.latitude = convertedCoor.latitude;
	coordinate.longitude = convertedCoor.longitude;
	
	return coordinate;
}

// MARK: PROPERTY

- (CLLocationCoordinate2D)coordinate {
	return CLLocationCoordinate2DMake(_latitude, _longitude);
}

- (NSString *)param {
	return [NSString stringWithFormat:@"%@,%@", @(_longitude), @(_latitude)];
}

@end
