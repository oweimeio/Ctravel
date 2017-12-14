//
//  HelpViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	CommentTypeForOrder,  //针对订单提意见
	CommentTypeForPlatform//针对平台提意见
} CommentType;

@interface HelpViewController : UIViewController

@property (assign, nonatomic) CommentType type;

@property (strong, nonatomic) NSString *serverCustomerId;

@property (strong, nonatomic) NSString *experienceId;

@end
