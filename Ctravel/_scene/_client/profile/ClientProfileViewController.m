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
@property (weak, nonatomic) IBOutlet UILabel *isServerLabel;

@end

@implementation ClientProfileViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_nameLabel.text = [NSString stringWithFormat:@"%@%@", ![User sharedUser].familyName ? @"姓" : [User sharedUser].familyName, ![User sharedUser].firstName ? @"名" : [User sharedUser].firstName];
	
	[_avatarBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[User sharedUser].avatarUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    
    if ([User sharedUser].isServer) {
        _isServerLabel.text = @"切换到达人模式";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
	HelpViewController *helpVc = [HelpViewController new];
	helpVc.type = CommentTypeForPlatform;
    [self.navigationController pushViewController:helpVc animated:YES];
}

- (IBAction)masterViewPress:(id)sender {
	//判断身份  如果还不是达人  就先申请
	if ([User sharedUser].isServer) {
		[[AppDelegate app] switchAppType:AppTypePolice];
	}
	else {
		[self.navigationController pushViewController:[IDValidViewController new
                                                   ] animated:YES];
	}
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
