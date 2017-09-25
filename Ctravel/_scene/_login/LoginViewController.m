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

@property (weak, nonatomic) IBOutlet UIView *secondLineView;

@end

@implementation LoginViewController

- (void)setInfo:(NSDictionary *)info {
    _info = info;
    _titleLabel.text = info[@"title"];
    _firstRowLabel.text = info[@"firstRow"];
    if (info[@"secondRow"]) {
        _secondRowLabel.hidden = NO;
		_secondLineView.hidden = NO;
        _secondRowLabel.text = info[@"secondRow"];
        _passwordTextField.hidden = NO;
    }
    else {
        _secondRowLabel.hidden = YES;
		_secondLineView.hidden = YES;
        _passwordTextField.hidden = YES;
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
        }   break;
        case LoginTypeStepName: {
            _phoneTextField.keyboardType = UIKeyboardTypeDefault;
        }   break;
        case LoginTypeStepPhone: {
            _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        }   break;
        case LoginTypeStepCode: {
            _phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }   break;
        case LoginTypeStepPwd: {
            _phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _phoneTextField.secureTextEntry = YES;
            _passwordTextField.secureTextEntry = YES;
        }   break;
		default:
			break;
	}
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self setViewStyle];
	
    [self.view bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
    
	[self setInfo:_info];
	
	[self setType:_type];
}

- (IBAction)ensureBtnClick:(id)sender {
    
    if (_type == LoginTypeStepName) {
        //存姓名
		[User sharedUser].firstName = _phoneTextField.text;
		[User sharedUser].familyName = _passwordTextField.text;
		
        LoginViewController *loginVc = [LoginViewController new];
        loginVc.info = @{@"title": @"您的电话号码?", @"firstRow": @"电话号码", @"buttonTitle": @"继续"};
        loginVc.type = LoginTypeStepPhone;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    else if (_type == LoginTypeStepPhone) {
		//存电话
		if (_phoneTextField.text.length == 0) {
			[SVProgressHUD showErrorWithStatus:@"电话号码不能为空"];
			return;
		}
		else if (![_phoneTextField.text isPhoneNumber]) {
			[SVProgressHUD showErrorWithStatus:@"请输入正确的电话号码"];
			return;
		}
        [[CoreAPI core] GETURLString:@"" withParameters:@{} success:^(id ret) {
            
        } error:^(NSString *code, NSString *msg, id ret) {
            
        } failure:^(NSError *error) {
            
        }];
        
		[User sharedUser].phone = _phoneTextField.text;
        LoginViewController *loginVc = [LoginViewController new];
        loginVc.info = @{@"title": @"输入验证码", @"firstRow": @"验证码", @"buttonTitle": @"继续"};
        loginVc.type = LoginTypeStepCode;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
	else if (_type == LoginTypeStepCode) {
		User *usr = [User sharedUser];
		usr.phone = _phoneTextField.text;
		LoginViewController *loginVc = [LoginViewController new];
		loginVc.info = @{@"title": @"输入密码", @"firstRow": @"密码", @"secondRow": @"确认密码", @"buttonTitle": @"注册"};
		loginVc.type = LoginTypeStepPwd;
		[self.navigationController pushViewController:loginVc animated:YES];
	}
    else if (_type == LoginTypeStepPwd) {
        if (![_phoneTextField.text isEqualToString:_passwordTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
            return;
        }
        
    }
	else if (_type == LoginTypeLogin) {
        [self.view endEditing:YES];
        [[AppDelegate app] switchAppType:AppTypeResident];
        [HAApp current].atoken = @"asdfsadfsfdf";
        return;
		NSDictionary *params = @{
								 @"account": _phoneTextField.text,
								 @"password": _passwordTextField.text,
								 @"captcha": @"",
								 @"captchaId": @"",
								 };
		[[CoreAPI core] GETURLString:LOGIN_LOGIN withParameters:params success:^(id ret) {
            NSLog(@"%@",ret);
            [[HAApp current] setAtoken:ret[@"data"][@"token"]];
            [User sharedUser].userId = ret[@"data"][@"userId"];
			[[AppDelegate app] switchAppType:AppTypeResident];
		} error:^(NSString *code, NSString *msg, id ret) {
            [SVProgressHUD showErrorWithStatus:msg];
		} failure:^(NSError *error) {
			
		}];
	}

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
