//
//  LYAreaPicker.h
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-27.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

typedef void (^ didSelectArea)(NSString *provinceName, NSString *cityName, NSString *areaName, NSString *zipCode);

@interface LYAreaPicker : UIControl

@property (nonatomic, assign) BOOL removeWhenDismissed;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *zipCode;

- (void)show;
- (void)showInView:(UIView *)view;

- (void)setSelectBlock:(didSelectArea)selectBlock;

@end
