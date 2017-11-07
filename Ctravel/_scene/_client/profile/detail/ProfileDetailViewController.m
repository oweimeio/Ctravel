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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"编辑" style:UIBarButtonItemStyleDone handler:^(id sender) {
        ProfileEditViewController *editVc = [ProfileEditViewController new];
		editVc.dataSource =  _dataSource;
        [self.navigationController pushViewController:editVc animated:YES];
    }];
    
    [self requestUserInfo];
    
}

//查看评价
- (IBAction)lookEv:(id)sender {
	//customerId
}


- (void)requestUserInfo {
    NSDictionary *param = @{
                            @"token":[User sharedUser].token,
                            @"customerId":[User sharedUser].userId
                            };
    [[CoreAPI core] GETURLString:@"/customer" withParameters:param success:^(id ret) {
        self.dataSource = ret[@"customerDetail"];
		[self setInfo];
    } error:^(NSString *code, NSString *msg, id ret) {
        [SVProgressHUD showErrorWithStatus:msg];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
    }];
}

- (void)setInfo {
	self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_dataSource[@"firstName"],_dataSource[@"familyName"]];
	self.validLabel.text = @"电话号码";
	[self.avatarImageView setImageWithURLString:_dataSource[@"headImg"] andPlaceholderNamed:@"placeholder-none"];
	self.cityLabel.text = _dataSource[@"area"];
	self.createTimeLabel.text = [[NSDate dateWithTimeIntervalSince1970:[_dataSource[@"createTime"] doubleValue]/1000] stringWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI];
	self.aboutLabel.text = @"";
	self.languageLabel.text = _dataSource[@"language"];
	self.schoolLabel.text = _dataSource[@"school"];
	self.jobLabel.text = _dataSource[@"job"];
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
