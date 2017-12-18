//
//  FavDetailViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *imgScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *simpleDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *exContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *goWhereLabel;

@property (weak, nonatomic) IBOutlet UILabel *meetPointLabel;

@property (weak, nonatomic) IBOutlet UIView *meetMapView;

@property (weak, nonatomic) IBOutlet UILabel *exHaveLabel;

@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (weak, nonatomic) IBOutlet UILabel *masterRegulationsLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *exPeopleCount;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic) NSDictionary *dataSource;

@end
