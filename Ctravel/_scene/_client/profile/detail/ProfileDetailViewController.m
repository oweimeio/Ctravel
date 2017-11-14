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
	[self setInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"编辑" style:UIBarButtonItemStyleDone handler:^(id sender) {
        ProfileEditViewController *editVc = [ProfileEditViewController new];
        [self.navigationController pushViewController:editVc animated:YES];
    }];
}

//查看评价
- (IBAction)lookEv:(id)sender {
	//customerId
}


- (void)setInfo {
	User *user = [User sharedUser];
	self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",!user.firstName?@"名字":user.firstName,!user.familyName?@"姓氏":user.familyName];
	self.validLabel.text = @"电话号码";
	[self.avatarImageView setImageWithURLString:user.avatarUrl andPlaceholderNamed:@"defaultHeadImage"];
	self.cityLabel.text = !user.city?@"暂无位置信息":user.city;
	self.createTimeLabel.text = user.registerTime;
	//[[NSDate dateWithTimeIntervalSince1970:[_dataSource[@"createTime"] doubleValue]/1000] stringWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI];
	self.aboutLabel.text = user.about;
	self.languageLabel.text = user.language;
	self.schoolLabel.text = user.school;
	self.jobLabel.text = user.job;
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
