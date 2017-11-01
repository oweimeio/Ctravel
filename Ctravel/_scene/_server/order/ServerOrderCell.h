//
//  ServerOrderCell.h
//  Ctravel
//
//  Created by 华奥 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const ServerOrderCellIdentifier;

@interface ServerOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
