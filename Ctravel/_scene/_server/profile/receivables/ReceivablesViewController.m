//
//  ReceivablesViewController.m
//  Ctravel
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReceivablesViewController.h"
#import "PreHeader.h"

@interface ReceivablesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *zfbIDLabel;

@end

@implementation ReceivablesViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"ReceivablesViewController" bundle:nil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
	
	if ([User sharedUser].payAccount) {
		_zfbIDLabel.text = [User sharedUser].payAccount;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClick:(id)sender {
	[User sharedUser].payAccount = _zfbIDLabel.text;
	[SVProgressHUD showSuccessWithStatus:@"保存成功"];
	[self.navigationController popViewControllerAnimated:YES];
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
