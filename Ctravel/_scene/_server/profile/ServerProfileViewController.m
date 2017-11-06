//
//  ServerProfileViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerProfileViewController.h"
#import "PreHeader.h"
#import "SettingViewController.h"
#import "ReceivablesViewController.h"
#import "IncomeViewController.h"

@interface ServerProfileViewController ()

@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ServerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
	_nameLabel.text = [NSString stringWithFormat:@"%@ %@", ![User sharedUser].familyName ? @"名字" : [User sharedUser].familyName, ![User sharedUser].firstName ? @"姓氏" : [User sharedUser].firstName];
    
    [_avatarBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[User sharedUser].avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholder-none"]];
}

//MARK: - ACTION

- (IBAction)avatarBtnClick:(id)sender {
    
}

- (IBAction)IncomeViewPress:(id)sender {
    [self.navigationController pushViewController:[IncomeViewController new] animated:YES];
}


- (IBAction)settingViewPress:(id)sender {
    SettingViewController *settingVc = [SettingViewController new];
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (IBAction)bindReceivablesStyle:(id)sender {
    [self.navigationController pushViewController:[ReceivablesViewController new] animated:YES];
}

- (IBAction)changeToClientViewPress:(id)sender {
    [[AppDelegate app] switchAppType:AppTypeResident];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
