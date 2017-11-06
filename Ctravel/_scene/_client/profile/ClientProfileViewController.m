//
//  ClientProfileViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientProfileViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import "MasterViewController.h"
#import "ProfileDetailViewController.h"
#import "PreHeader.h"

@interface ClientProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ClientProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
	_nameLabel.text = [NSString stringWithFormat:@"%@ %@", ![User sharedUser].familyName ? @"名字" : [User sharedUser].familyName, ![User sharedUser].firstName ? @"姓氏" : [User sharedUser].firstName];
    
    [_avatarBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[User sharedUser].avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholder-none"]];
}

//MARK: -ACTION
- (IBAction)avatarBtnClick:(id)sender {
    [self.navigationController pushViewController:[ProfileDetailViewController new] animated:YES];
}

- (IBAction)settingViewPress:(id)sender {
    [self.navigationController pushViewController:[SettingViewController new
                                                   ] animated:YES];
}

- (IBAction)helpViewPress:(id)sender {
    [self.navigationController pushViewController:[HelpViewController new
                                                   ] animated:YES];
}

- (IBAction)masterViewPress:(id)sender {
//    [self.navigationController pushViewController:[MasterViewController new
//                                                   ] animated:YES];
    [[AppDelegate app] switchAppType:AppTypePolice];
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
