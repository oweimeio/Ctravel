//
//  CreatePageViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CreatPageStyleSelect,
    CreatPageStyleWrite,
    CreatPageStyleWriteDes,
} CreatPageStyle;

typedef enum : NSUInteger {
    CommonDesTypeStyle,
    CommonDesTypeCity,
    CommonDesTypeTitle,
    CommonDesTypeDes,
    CommonDesTypeAddress,
    CommonDesTypeMark,
    CommonDesTypeMustKnow,
    CommonDesTypeRequire,
    CommonDesTypePlace,
    CommonDesTypeTime,
    CommonDesTypePic,
    CommonDesTypePrice,
} CommonDesType;

@interface CreatePageViewController : UIViewController

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, assign) CreatPageStyle style;

@property (assign, nonatomic) CommonDesType type;

@end
