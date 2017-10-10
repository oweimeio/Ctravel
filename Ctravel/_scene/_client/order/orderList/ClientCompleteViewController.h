//
//  ClientCompleteViewController.h
//  Ctravel
//
//  Created by apple on 2017/10/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OrderTypeCompleted,
    OrderTypeFuture
} OrderType;

@interface ClientCompleteViewController : UIViewController

@property (assign, nonatomic) OrderType type;

@end
