//
//  LYPicker.h
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-12.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

typedef void (^ didSelectDate)(NSDate *date);

@interface LYDatePicker : UIControl

@property (nonatomic, assign) UIDatePickerMode datePickerMode;

@property (nonatomic, assign) BOOL removeWhenDismissed;

- (void)show;
- (void)showInView:(UIView *)view;

- (void)setSelectBlock:(didSelectDate)selectBlock;

@end
