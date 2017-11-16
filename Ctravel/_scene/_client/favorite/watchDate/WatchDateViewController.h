//
//  WatchDateViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseDateDelegate <NSObject>
@optional

- (void)chooseDate:(NSString *) date;

@end

@interface WatchDateViewController : UIViewController

@property (nonatomic, strong) NSDictionary *detailData;

@property (nonatomic, strong) NSString *expId;

@property (nonatomic, weak) id<ChooseDateDelegate> delegate;

@end
