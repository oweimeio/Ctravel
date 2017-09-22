//
//  ClientMsgCell.h
//  Ctravel
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientMsgCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *dataSource;

+ (instancetype)clientMsgCellInTableView:(UITableView *)tableView;

@end
