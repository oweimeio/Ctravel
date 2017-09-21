//
//  HotDestinationCell.m
//  Ctravel
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HotDestinationCell.h"
#import "PreHeader.h"

@interface HotDestinationCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HotDestinationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [_picImageView setImageWithURLString:dataSource[@"image"] andPlaceholderNamed:@""];
    _nameLabel.text = dataSource[@"title"];
}

@end
