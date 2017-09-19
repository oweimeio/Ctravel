//
//  HABarButtonItem.h
//  CORE
//
//  CREATED BY LUO YU ON 2017-06-29.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@class HABarButtonItem;

typedef void(^HABarButtonItemActionBlock)(HABarButtonItem *item);

@interface HABarButtonItem : UIBarButtonItem

// Each time you change one of the properties, the badge will refresh with your changes

/**
 Badge value to be display
 */
@property (nonatomic) NSString *badgeValue;

/**
 Badge background color
 */
@property (nonatomic) UIColor *badgeBGColor;

/**
 Badge text color
 */
@property (nonatomic) UIColor *badgeTextColor;

/**
 Badge font
 */
@property (nonatomic) UIFont *badgeFont;

/**
 Padding value for the badge
 */
@property (nonatomic) CGFloat badgePadding;

/**
 Minimum size badge to small
 */
@property (nonatomic) CGFloat badgeMinSize;

/**
 Value x for offseting the badge over the BarButtonItem you picked
 */
@property (nonatomic) CGFloat badgeOriginX;

/**
 Value y for offseting the badge over the BarButtonItem you picked
 */
@property (nonatomic) CGFloat badgeOriginY;

/**
 In case of numbers, remove the badge when reaching zero
 */
@property BOOL shouldHideBadgeAtZero;

/**
 Badge has a bounce animation when value changes
 */
@property BOOL shouldAnimateBadge;

/**
 initial

 @param customButton button
 @return instance
 */
- (instancetype)initWithCustomUIButton:(UIButton *)customButton;

- (instancetype)initWithImage:(UIImage *)icon andAction:(HABarButtonItemActionBlock)actionblock;

@end
