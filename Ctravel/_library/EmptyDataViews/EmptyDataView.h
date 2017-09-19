//
//  EmptyDataView.h
//  WJW2
//
//  CREATED BY LUO YU ON 2016-08-15.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface EmptyDataView : UIView

@property (nonatomic, weak) UILabel *lblHint;
@property (nonatomic, weak) UIImageView *ivIcon;
@property (nonatomic, assign) CGRect frame;
+ (instancetype)view;

@end
