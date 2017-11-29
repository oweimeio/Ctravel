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
    if (sender.selected) {
        NSDictionary *param = @{
                                @"token":[User sharedUser].token,
                                @"customerId":[User sharedUser].userId,
                                @"experienceId":_dataSource[@"experienceId"]
                                };
        [[CoreAPI core] POSTURLString:@"/experience/cancelFavorite" withParameters:param success:^(id ret) {
            sender.selected = NO;
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
        } error:^(NSString *code, NSString *msg, id ret) {
            [SVProgressHUD showErrorWithStatus:msg];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
        }];
    }
    else {
        NSDictionary *param = @{
                                @"token":[User sharedUser].token,
                                @"customerId":[User sharedUser].userId,
                                @"experienceId":_dataSource[@"experienceId"]
                                };
        [[CoreAPI core] POSTURLString:@"/experience/favorite" withParameters:param success:^(id ret) {
            sender.selected = YES;
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        } error:^(NSString *code, NSString *msg, id ret) {
            [SVProgressHUD showErrorWithStatus:msg];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
        }];
    }
}


- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [_picImageView setImageWithURLString:[dataSource[@"imageUrl"] componentsSeparatedByString:@","].firstObject andPlaceholderNamed:@"placeholder-none"];
    _nameLabel.text = dataSource[@"title"];
	_moneyLabel.text = [NSString stringWithFormat:@"￥%.0f ·%@条评价 %@",[dataSource[@"price"] floatValue],!dataSource[@"commentNum"]?@"0":dataSource[@"commentNum"], !dataSource[@"city"] ? @"" : dataSource[@"city"]];
    if ([dataSource[@"isFavourite"] isEqualToString:@"1"]) {
        _heartButton.selected = YES;
    }
    else {
        _heartButton.selected = NO;
    }
    
}

@end
