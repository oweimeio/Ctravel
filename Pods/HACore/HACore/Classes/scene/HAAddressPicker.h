//
//  HAAddressPicker.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-28.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>
#import <UIKit/UIKit.h>

typedef void (^ didSelectAddress)(NSDictionary *address);

@interface HAAddressPicker : LYPopView

/**
 显示一个PopView，并设置其完成选择的块

 @param addressBlock 完成选择的块
 */
+ (void)showPickerWithSelected:(didSelectAddress)addressBlock;

/**
 设置完成选择的块

 @param addressBlock 完成选择的块
 */
- (void)setSelectedBlock:(didSelectAddress)addressBlock;

@end

FOUNDATION_EXPORT NSString *const HAAddressCellIdentifier;

/**
 地址单元格
 */
@interface HAAddressCell : UITableViewCell

/**
 地址单元格标题
 */
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;

/**
 地址单元格选择状态
 */
@property (nonatomic, weak) IBOutlet UILabel *lblSelection;

@end

/**
 地址选择器列表头视图
 */
@interface HAAddressCellHeader : UIView

/**
 头视图类方法生成器

 @param title 标题字符串
 @param width 视图宽度
 @return 视图实例
 */
+ (instancetype)headerWithTitle:(NSString *)title andWidth:(CGFloat)width;

@end
