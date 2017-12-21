//
//  ProfileDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "ProfileEditViewController.h"
#import "PreHeader.h"

@interface ProfileDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *validLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

@property (weak, nonatomic) IBOutlet UILabel *jobLabel;

@property (strong, nonatomic) NSDictionary *dataSource;

@end

@implementation ProfileDetailViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"ProfileDetailViewController" bundle:[NSBundle mainBundle]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (_type == profileTypeOthers) {
		[self requestUserInfo];
	}
	else {
		[self setInfo];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	if (_type == profileTypeOthers) {
		
	}
	else {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"编辑" style:UIBarButtonItemStyleDone handler:^(id sender) {
			ProfileEditViewController *editVc = [ProfileEditViewController new];
			[self.navigationController pushViewController:editVc animated:YES];
		}];
	}
}

//查看评价
- (IBAction)lookEv:(id)sender {
	//customerId
	EvaluationViewController *evalVc = [EvaluationViewController new];
	[self.navigationController pushViewController:evalVc animated:YES];
}


- (void)setInfo {
	User *user = [[User sharedUser] getUserData];
	self.nameLabel.text = [NSString stringWithFormat:@"%@%@",!user.familyName?@"姓":user.familyName,!user.firstName?@"名":user.firstName];
    self.validLabel.text = [NSString stringWithFormat:@"%@%@%@", @"电话号码",user.isServer?@"·身份验证":@"", user.email ? @"·电子邮箱" :@""];
	[self.avatarImageView setImageWithURLString:user.avatarUrl andPlaceholderNamed:@"defaultHeadImage"];
	self.cityLabel.text = !user.city||user.city.length == 0?@"暂无位置信息":user.city;
	self.createTimeLabel.text = user.registerTime;
	self.aboutLabel.text = user.about;
	self.languageLabel.text = user.language;
	self.schoolLabel.text = user.school;
	self.jobLabel.text = user.job;
}

- (void)setInfoWithDic: (NSDictionary *)dic {
	self.nameLabel.text = [NSString stringWithFormat:@"%@%@",dic[@"familyName"], dic[@"firstName"]];
	self.validLabel.text = [NSString stringWithFormat:@"%@%@%@", @"电话号码",dic[@"isServer"]?@"·身份验证":@"", dic[@"email"]? @"·电子邮箱" :@""];
	[self.avatarImageView setImageWithURLString:dic[@"headImg"] andPlaceholderNamed:@"defaultHeadImage"];
	self.cityLabel.text = dic[@"area"];
	self.createTimeLabel.text = [[NSDate dateWithTimeIntervalSince1970:[dic[@"createTime"] doubleValue]/1000] stringWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI];
	self.aboutLabel.text = dic[@"about"];
	self.languageLabel.text = dic[@"language"];
	self.schoolLabel.text = dic[@"school"];
	self.jobLabel.text = dic[@"job"];
}

- (void)requestUserInfo {
	if (!_customerId) {
		NSLog(@"CUSTOMERID IS EMPTY");
		return;
	}
	NSDictionary *param = @{
							@"token":[User sharedUser].token,
							@"customerId":_customerId
							};
	[[CoreAPI core] GETURLString:@"/customer" withParameters:param success:^(id ret) {
		[self setInfoWithDic: ret[@"customerDetail"]];
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
	}];
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
