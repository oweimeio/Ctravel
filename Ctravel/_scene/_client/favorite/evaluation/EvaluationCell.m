//
//  EvaluationCell.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EvaluationCell.h"
#import "PreHeader.h"

NSString *const EvaluationCellIdentifier = @"EvaluationCellIdentifier";

@implementation EvaluationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.reserveBtn.layer.cornerRadius = 5;
    self.reserveBtn.layer.borderWidth = 1;
    self.reserveBtn.layer.borderColor = [[UIColor colorWithHex:@"1890B5" andAlpha:1] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
