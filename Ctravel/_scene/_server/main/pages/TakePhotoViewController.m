//
//  TakePhotoViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "CreatePageViewController.h"
#import "PreHeader.h"

@interface TakePhotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *preViewBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultTheme];
}

- (IBAction)preViewBtnClick:(id)sender {
    
}


- (IBAction)nextStepBtnClick:(id)sender {
    CreatePageViewController *createVc = [CreatePageViewController new];
    createVc.info = @{@"title":@"为您提供的体验设定一个适中的价格？"};
    createVc.type = CommonDesTypePrice;
    [self.navigationController pushViewController: createVc animated:YES];
}

- (void)setDefaultTheme {
    self.preViewBtn.layer.borderWidth = 2;
    self.preViewBtn.layer.borderColor = [[UIColor colorWithHex:@"1890B5" andAlpha:1] CGColor];
    self.preViewBtn.layer.cornerRadius = 5;
    self.preViewBtn.layer.masksToBounds = YES;
    self.nextStepBtn.layer.cornerRadius = 5;
    self.nextStepBtn.layer.masksToBounds = YES;
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
