//
//  HAEmptyHintView.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-06.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface HAEmptyHintView : UIView

/**
 提示标签
 */
@property (nonatomic, weak) UILabel *lblHint;

/**
 提示图标
 */
@property (nonatomic, weak) UIImageView *ivIcon;

/**
 提示文字内容
 */
@property (nonatomic, strong) IBInspectable NSString *hint;

/**
 提示图标文件名
 */
@property (nonatomic, strong) IBInspectable NSString *hintImageName;

/**
 类方法初始化

 @return 实例
 */
+ (instancetype)view;

/**
 类方法带标题与图片名的初始化

 @param title 标题
 @param imageName 图片名
 @return 实例
 */
+ (instancetype)viewWithTitle:(NSString *)title andIconNamed:(NSString *)imageName;

+ (instancetype)viewWithTitle:(NSString *)title andIcon:(UIImage *)image;

/**
 父容器内居中
 */
- (void)centerInContainer;

@end
