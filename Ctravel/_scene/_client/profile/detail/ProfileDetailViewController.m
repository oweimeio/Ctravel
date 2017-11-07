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
        [self.navigationController pushViewController:editVc animated:YES];
    }];
    
    [self requestUserInfo];
    
}

- (void)requestUserInfo {
    NSDictionary *param = @{
                            @"token":[User sharedUser].token,
                            @"customerId":[User sharedUser].userId
                            };
    [[CoreAPI core] GETURLString:@"/customer" withParameters:param success:^(id ret) {
        self.dataSource = ret[@"customerDetail"];
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
