//
//  LoginChooseViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginChooseViewController.h"
#import "PreHeader.h"

@interface LoginChooseViewController () {
    
    __weak IBOutlet UIButton *createAccountBtn;
    
    __weak IBOutlet UIButton *loginBtn;
}

@end

@implementation LoginChooseViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    createAccountBtn.layer.cornerRadius = 5;
    createAccountBtn.layer.borderWidth = 1;
    createAccountBtn.layer.borderColor = [[UIColor colorWithHex:@"#1890B5" andAlpha:1.0] CGColor];
    
    loginBtn.layer.cornerRadius = 5;
    
}

// MARK: - ACTION
- (IBAction)createAccountBtnClick:(id)sender {
	LoginViewController *loginVc = [LoginViewController new];
	loginVc.info = @{@"title": @"您叫什么名字?", @"firstRow": @"名字", @"secondRow": @"姓氏", @"buttonTitle": @"继续"};
	loginVc.type = LoginTypeStepName;
	[self.navigationController pushViewController:loginVc animated:YES];
}

- (IBAction)loginBtnClick:(id)sender {
	LoginViewController *loginVc = [LoginViewController new];
	loginVc.info = @{@"title": @"登录", @"firstRow": @"电话号码", @"secondRow": @"密码"};
	loginVc.type = LoginTypeLogin;
    [self.navigationController pushViewController:loginVc animated:YES];
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
