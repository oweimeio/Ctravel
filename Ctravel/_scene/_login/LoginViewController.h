//
//  LoginViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	LoginTypeNormal,
	LoginTypeLogin,//注册
	LoginTypeStepPhone,   //电话
	LoginTypeStepCode,	  //验证码
	LoginTypeStepPwd,	  //密码
} LoginType;

@interface LoginViewController : UIViewController

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, assign) LoginType type;

@end
