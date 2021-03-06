//
//  LYPicker.h
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-12.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

typedef void (^ didSelectItem)(NSInteger idx, NSDictionary *item);

@interface LYPicker : UIControl

@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) NSString *keyTitle;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) BOOL removeWhenDismissed;

- (void)show;
- (void)showInView:(UIView *)view;

- (void)setSelectBlock:(didSelectItem)selectBlock;

@end
