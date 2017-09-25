//
//  CommonDesViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CommonDesTypeStyle,
    CommonDesTypeCity,
    CommonDesTypeTitle,
    CommonDesTypeDes,
    CommonDesTypeAddress,
    CommonDesTypeMark,
    CommonDesTypeRequire,
    CommonDesTypePlace,
    CommonDesTypeTime,
    CommonDesTypePrice,
} CommonDesType;

@interface CommonDesViewController : UIViewController

@property (assign, nonatomic) CommonDesType type;

@end
