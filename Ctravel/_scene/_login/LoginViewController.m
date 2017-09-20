//
//  LoginViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "PreHeader.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstRowLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondRowLabel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;

@end

@implementation LoginViewController

- (void)setInfo:(NSDictionary *)info {
    _info = info;
    _titleLabel.text = info[@"title"];
    _firstRowLabel.text = info[@"firstRow"];
    if (info[@"secondRow"]) {
        _secondRowLabel.hidden = NO;
        _secondRowLabel.text = info[@"secondRow"];
    }
    else {
        _secondRowLabel.hidden = YES;
    }
    
	if (info[@"buttonTitle"]) {
		[_ensureBtn setTitle:info[@"buttonTitle"] forState:UIControlStateNormal];
	}
}

//不同的type 有不同的布局风格
- (void)setType:(LoginType)type {
	_type = type;
	switch (type) {
		case LoginTypeNormal: {
			_passwordTextField.secureTextEntry = NO;
			_passwordTextField.keyboardType = UIKeyboardTypeDefault;
		}	break;
		case LoginTypeLogin: {
			_passwordTextField.secureTextEntry = YES;
			_passwordTextField.keyboardType = UIKeyboardTypePhonePad;
		}
		default:
			break;
	}
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self setViewStyle];
	
    [self.view endEditing:YES];
    
	[self setInfo:_info];
	
	[self setType:_type];
}

- (IBAction)ensureBtnClick:(id)sender {
    
    if (_type == LoginTypeStepName) {
        //存姓名
        LoginViewController *loginVc = [LoginViewController new];
        loginVc.info = @{@"title": @"您的电话号码?", @"firstRow": @"电话号码", @"name": _phoneTextField.text, @"firstname": _passwordTextField.text, @"buttonTitle": @"继续"};
        loginVc.type = LoginTypeStepName;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    else if (_type == LoginTypeStepPhone) {
        LoginViewController *loginVc = [LoginViewController new];
        loginVc.info = @{@"title": @"输入验证码", @"firstRow": @"验证码", @"name": _phoneTextField.text, @"firstname": _passwordTextField.text, @"buttonTitle": @"继续"};
        loginVc.type = LoginTypeStepName;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    NSDictionary *params = @{
                             @"account": _phoneTextField.text,
                             @"password": _passwordTextField.text,
                             @"captcha": @"",
                             @"captchaId": @"",
                             };
    [[CoreAPI core] GETURLString:LOGIN_LOGIN withParameters:params success:^(id ret) {
        [[AppDelegate app] switchAppType:AppTypeResident];
    } error:^(NSInteger code, NSString *msg, id ret) {
        NSLog(@"%@",msg);
    } failure:^(NSError *error) {
        
    }];
    
	
}


- (void)setViewStyle {
	_ensureBtn.layer.borderWidth = 2;
	_ensureBtn.layer.borderColor = [[UIColor colorWithHex:@"#1890B5" andAlpha:1.0] CGColor];
	_ensureBtn.layer.cornerRadius = 5;
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
