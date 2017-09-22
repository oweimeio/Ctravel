//
//  ClientMsgCell.m
//  Ctravel
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientMsgCell.h"
#import "PreHeader.h"

@interface ClientMsgCell ()

@property (weak, nonatomic) IBOutlet UIView *isReadView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ClientMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)clientMsgCellInTableView:(UITableView *)tableView {
    static NSString *ClientMsgCellIdentifier = @"ClientMsgCellIdentifier";
    ClientMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:ClientMsgCellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ClientMsgCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [self.avatarImageView setImageWithURLString:dataSource[@"avatarUrl"] andPlaceholderNamed:@""];
    self.nameLabel.text = dataSource[@"name"];
    self.contentLabel.text = dataSource[@"content"];
}


@end
