//
//  FavoriteViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FavTypeAll,     //所有
    FavTypeOnlyFav, //仅收藏
    FavTypeUnFav,   //未收藏
} FavType;

@interface FavoriteViewController : UIViewController

@property (assign, nonatomic) FavType type;

@property (strong, nonatomic) NSString *keywords;

@property (assign, nonatomic) BOOL hideNavBar;

@property (strong, nonatomic) NSString *titleStr;

@end
