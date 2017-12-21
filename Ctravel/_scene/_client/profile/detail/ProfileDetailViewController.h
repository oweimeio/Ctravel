//
//  ProfileDetailViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	profileTypeSelf,
	profileTypeOthers,
} profileType;

@interface ProfileDetailViewController : UIViewController

@property (assign, nonatomic) profileType type;

@property (strong, nonatomic) NSString *customerId;

@end
