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
			if ([[User sharedUser] getUserData].phone) {
				_phoneTextField.text = [[User sharedUser] getUserData].phone;
			}
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
        [[CoreAPI core] GETURLString: [NSString stringWithFormat:@"/sms/%@/1",_phoneTextField.text] withParameters:@{} success:^(id ret) {
			[User sharedUser].validCode = ret[@"code"];
        } error:^(NSString *code, NSString *msg, id ret) {
            
        } failure:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"验证码发送失败"];
        }];
        
		[User sharedUser].phone = _phoneTextField.text;
        LoginViewController *loginVc = [LoginViewController new];
        loginVc.info = @{@"title": @"输入验证码", @"firstRow": @"验证码", @"buttonTitle": @"继续"};
        loginVc.type = LoginTypeStepCode;
        [self.navigationController pushViewController:loginVc animated:YES];
    }
	else if (_type == LoginTypeStepCode) {
		if(![_phoneTextField.text isEqualToString:[User sharedUser].validCode]) {
			[SVProgressHUD showErrorWithStatus:@"输入的验证不正确"];
			return;
		}
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
		NSDictionary *params = @{
								 @"account": [User sharedUser].phone,
								 @"password": _passwordTextField.text,
								 @"firstName": [User sharedUser].firstName,
								 @"familyName": [User sharedUser].familyName
								 };
		[[CoreAPI core] GETURLString:REGISTER_REGISTER withParameters:params success:^(id ret) {
			NSLog(@"%@",ret);
			[SVProgressHUD showSuccessWithStatus:@"注册成功"];
			[[User sharedUser] saveUserData];
			//[[HAApp current] logout];
			[[AppDelegate app] switchAppType:AppTypeLogin];
		} error:^(NSString *code, NSString *msg, id ret) {
			[SVProgressHUD showErrorWithStatus:msg];
		} failure:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"网络错误"];
		}];
		
    }
	else if (_type == LoginTypeLogin) {
        [self.view endEditing:YES];
		if (_phoneTextField.text.length == 0) {
			[SVProgressHUD showErrorWithStatus:@"请输入电话号码"];
			return;
		}
		else if (_passwordTextField.text.length == 0) {
			[SVProgressHUD showErrorWithStatus:@"请输入密码"];
			return;
		}
		[SVProgressHUD showWithStatus:@"登录中..."];
		NSDictionary *params = @{
								 @"account": _phoneTextField.text,
								 @"password": _passwordTextField.text,
								 @"captcha": @"",
								 @"captchaId": @"",
								 };
		[[CoreAPI core] GETURLString:LOGIN_LOGIN withParameters:params success:^(id ret) {
            NSLog(@"%@",ret);
            [User sharedUser].isLogin = YES;
            [User sharedUser].token = ret[@"data"][@"token"];
            [User sharedUser].userId = ret[@"data"][@"userId"];
			[User sharedUser].phone = _phoneTextField.text;
			[SVProgressHUD dismiss];
			[self requestUserInfo];
			[[AppDelegate app] switchAppType:AppTypeResident];
		} error:^(NSString *code, NSString *msg, id ret) {
            [SVProgressHUD showErrorWithStatus:msg];
		} failure:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:@"网络错误"];
		}];
	}

}

- (void)requestUserInfo {
	NSDictionary *param = @{
							@"token":[User sharedUser].token,
							@"customerId":[User sharedUser].userId
							};
	[[CoreAPI core] GETURLString:@"/customer" withParameters:param success:^(id ret) {
		[[User sharedUser] setValuesForKeysWithDictionary:ret[@"customerDetail"]];
		[[RCIM sharedRCIM] connectWithToken:[User sharedUser].imToken success:^(NSString *userId) {
			NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
		} error:^(RCConnectErrorCode status) {
			NSLog(@"登陆的错误码为:%zi", status);
		} tokenIncorrect:^{
			//token过期或者不正确。
			//如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
			//如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
			NSLog(@"token错误");
		}];
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
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
