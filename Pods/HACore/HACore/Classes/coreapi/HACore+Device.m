//
//  HACore+Device.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-03-24.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HACore+Device.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <LYCategory/LYCategory.h>
#import "HACoreHeader.h"

@implementation HACore (Device)

- (BOOL)isCameraAuthorized {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [UIAlertController showAlertFromView:vc withTitle:@"" andMessage:[NSString stringWithFormat:@"App需要访问您的照相机\n请启用相机\n设置 -> 隐私 -> 相机"] cancelButtonTitle:@"关闭" cancelAction:^{}];
        
        return NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
        }];
    }
    return YES;
}

- (BOOL)isPhotoLibraryAuthorized {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [UIAlertController showAlertFromView:vc withTitle:@"" andMessage:[NSString stringWithFormat:@"App需要访问您的照片\n请启用照片\n设置 -> 隐私 -> 照片"] cancelButtonTitle:@"关闭" cancelAction:^{}];
        
        return NO;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
        }];
    }
    
    return YES;
}

- (void)submitWorkerCoordinate:(HACoordinate *)coordinate {
	
	HAUserWjw *me = [HAUserWjw userWithUID:[HAApp current].userID];
	NSDictionary *nesty = @{
							@"deptName":me.userInfo[@"user"][@"dept"][@"name"],
							@"headIcon":me.avatar != nil ? me.avatar : @"",
							@"_id":me.userInfo[@"user"][@"ytCode"],
							@"cellphone":me.mobile,
							@"deptType":me.userInfo[@"user"][@"dept"][@"type"],
							@"userId":me.UID,
							@"userName":me.username,
							@"_location":coordinate.param,
							@"deptCode":me.userInfo[@"user"][@"dept"][@"code"],
							@"jobName":me.userInfo[@"user"][@"jobs"][@"name"],
							};
	
	//NSString *logDatetime = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss" andTimezone:SHANGHAI];
	
	NSDictionary *param = @{
							@"tableid":[HAUserWjw userWithUID:[HAApp current].userID].yuntuTableID,
							@"key":[HAUserWjw userWithUID:[HAApp current].userID].yuntuKey,
							@"data":[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:nesty options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding],
							};
	[[HACoreAPI core] GETAbsoluteURLString:@"http://yuntuapi.amap.com/datamanage/data/update" withParameters:param success:^(id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

@end
