
//
//  ProfileEditViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "PreHeader.h"

@interface ProfileEditViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *familyNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *positionTextField;

@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;

@property (weak, nonatomic) IBOutlet UITextField *jobTextField;

@property (weak, nonatomic) IBOutlet UITextField *languageTextField;

@property (weak, nonatomic) IBOutlet UITextField *emalTextField;

@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//MARK: - ACTION


//拍照
- (IBAction)takePhotoBtnClick:(id)sender {
    
}

//选择性别
- (IBAction)chooseGenderBtnClick:(UIButton *)sender {
    LYPicker *picker = [LYPicker new];
    picker.datasource = @[
                          @{@"title":@"男",@"value":@"1"},
                          @{@"title":@"女",@"value":@"0"}
                          ];
    picker.keyTitle = @"title";
    [picker setSelectBlock:^(NSInteger idx, NSDictionary *item) {
        [sender setTitle:item[@"title"] forState:UIControlStateNormal];
    }];
    [picker showInView:self.view];
}

//选择出生日期
- (IBAction)chooseBornDate:(UIButton *)sender {
    LYDatePicker *datePicker = [LYDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setSelectBlock:^(NSDate *date) {
        NSLog(@"%@",date);
    }];
    [datePicker showInView:self.view];
}

//提供身份验证
- (IBAction)idValidBtnClick:(id)sender {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
