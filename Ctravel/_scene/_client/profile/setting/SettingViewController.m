//
//  SettingViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "PreHeader.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
}


//MARK: -ACTION

- (IBAction)commonViewPress:(id)sender {
    
}

- (IBAction)aboutViewPress:(id)sender {
    
}

- (IBAction)logoutViewPress:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
//        NSDictionary *param = @{
//                                @"token":[HAApp current].atoken,
//                                };
//        [[CoreAPI core] POSTURLString:@"/auth/loginOut.do" withParameters:param success:^(id ret) {
//            
//            
//        } error:^(NSString *code, NSString *msg, id ret) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
        
        // LET IT OUT
        [[HAApp current] logout];
        
        [[AppDelegate app] switchAppType:AppTypeLogin];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{}];
    
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
