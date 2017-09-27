//
//  ServerMainViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerMainViewController.h"
#import "CreatePageViewController.h"

@interface ServerMainViewController ()

@end

@implementation ServerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goToCreatePage:(id)sender {
    CreatePageViewController *createVc = [CreatePageViewController new];
    createVc.info = @{@"title":@"您打算创建什么风格的体验？",@"selectTitle":@"什么风格体验？",@"selectBtnTitle":@"户外体验（选择）",@"showTip":@"点击进一步了解风格意义"};
    createVc.type = CommonDesTypeStyle;
    [self.navigationController pushViewController: createVc animated:YES];
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
