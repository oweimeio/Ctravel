//
//  HotExperienceCell.m
//  Ctravel
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HotExperienceCell.h"
#import "PreHeader.h"

NSString *const hotExperienceCellInIdentifier = @"hotExperienceCellInIdentifier";

@interface HotExperienceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *heartButton;

@end

@implementation HotExperienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)heartBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [_picImageView setImageWithURLString:dataSource[@"imageUrl"] andPlaceholderNamed:@"placeholder-none"];
    _nameLabel.text = dataSource[@"title"];
	_moneyLabel.text = [NSString stringWithFormat:@"￥%.2f %@条评论 %@",[dataSource[@"price"] floatValue],!dataSource[@"commentNum"]?@"0":dataSource[@"commentNum"], !dataSource[@"city"] ? @"" : dataSource[@"city"]];
    if ([dataSource[@"isFavourite"] isEqualToString:@"1"]) {
        [_heartButton setImage:[UIImage imageNamed:@"solid-heart"] forState:UIControlStateNormal];
    }
    else {
        [_heartButton setImage:[UIImage imageNamed:@"empty-heart"] forState:UIControlStateNormal];
    }
    
}

@end
