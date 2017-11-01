//
//  ClientOrderCell.h
//  Ctravel
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const ClientOrderCellIdentifier;

@interface ClientOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
