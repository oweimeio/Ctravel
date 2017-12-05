//
//  ServerOrderDetailViewController.h
//  Ctravel
//
//  Created by apple on 2017/12/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerOrderHistoryListViewController.h"

@interface ServerOrderDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *dataSource;

@property (assign, nonatomic) OrderType type;

@end
