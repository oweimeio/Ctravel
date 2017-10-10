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

@interface ServerProfileViewController ()

@end

@implementation ServerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//MARK: - ACTION

- (IBAction)settingViewPress:(id)sender {
    SettingViewController *settingVc = [SettingViewController new];
    [self.navigationController pushViewController:settingVc animated:YES];
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
