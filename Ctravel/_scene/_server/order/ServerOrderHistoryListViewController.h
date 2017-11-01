//
//  ServerOrderHistoryListViewController.h
//  Ctravel
//
//  Created by 华奥 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	OrderTypeCompleted,
	OrderTypeFuture
} OrderType;

@interface ServerOrderHistoryListViewController : UIViewController

@property (assign, nonatomic) OrderType type;

@end
