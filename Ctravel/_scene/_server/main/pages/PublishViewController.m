//
//  PublishViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//预览
- (IBAction)preViewBtnClick:(id)sender {
	
}

//发布
- (IBAction)publishBtnClick:(id)sender {
	
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
