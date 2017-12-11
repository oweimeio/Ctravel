//
//  ClientOrderDetailViewController.h
//  Ctravel
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreHeader.h"
#import "ClientCompleteViewController.h"

@interface ClientOrderDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dataSource;

@property (assign, nonatomic) OrderType type;

@end
