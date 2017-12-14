
//
//  ProfileEditViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "PreHeader.h"
#import "IDValidViewController.h"

@interface ProfileEditViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *familyNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *aboutTextField;

@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
	
@property (weak, nonatomic) IBOutlet UIButton *bornDateBtn;
	
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;

@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;

@property (weak, nonatomic) IBOutlet UITextField *jobTextField;

@property (weak, nonatomic) IBOutlet UITextField *languageTextField;

@property (weak, nonatomic) IBOutlet UITextField *emalTextField;

@property (weak, nonatomic) IBOutlet UIButton *validIDBtn;
@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        User *user = [[User sharedUser] getUserData];
        user.firstName = self.nameTextField.text;
        user.familyName = self.familyNameTextField.text;
		user.about = self.aboutTextField.text;
        user.city = self.positionTextField.text;
        user.school = self.schoolTextField.text;
        user.job = self.jobTextField.text;
        user.language = self.languageTextField.text;
        user.email = self.emalTextField.text;
        [user saveUserData];
        [self saveUserInfo];
    }];
	[self setUsrInfo];
}

//MARK: - ACTION


//拍照
- (IBAction)takePhotoBtnClick:(UIButton *)sender {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIImagePickerController *ip = [[UIImagePickerController alloc] init];
	
	ip.allowsEditing = YES;
	
	[ip setBk_didCancelBlock:^(UIImagePickerController *imp) {
		[imp dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[ip setBk_didFinishPickingMediaBlock:^(UIImagePickerController *imp, NSDictionary *ret) {
		
		[SVProgressHUD showWithStatus:@"正在上传头像"];
		
		UIImage *photo = [ret[UIImagePickerControllerEditedImage] resize:(CGSize){750, 750}];
		
		[[CoreAPI core] POSTImage:photo progress:^(float completed, float total) {
			
		} success:^(id ret) {
			[_avatarImageView setImageWithURLString:ret[@"url"] andPlaceholderNamed:@"placeholder-none"];
			[User sharedUser].avatarUrl = ret[@"url"];
			[SVProgressHUD showSuccessWithFormatStatus:@"上传成功"];
			
		} apierror:^(NSString *code, NSString *msg, id ret) {
			[SVProgressHUD showErrorWithFormatStatus:@"%@", msg];
		} failure:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
		}];
		
		[imp dismissViewControllerAnimated:YES completion:^{}];
	}];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		
		ip.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		
		if (![[HACore core] isPhotoLibraryAuthorized]) {
			return;
		} else {
			// SHOW PICKER
			[self presentViewController:ip animated:YES completion:^{}];
		}
	}]];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		ip.sourceType = UIImagePickerControllerSourceTypeCamera;
		
		if (![[HACore core] isCameraAuthorized]) {
			return;
		} else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
			return;
		} else {
			// SHOW PICKER
			[self presentViewController:ip animated:YES completion:^{}];
		}
	}]];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
	}]];
	
	[self presentViewController:alert animated:YES completion:^{}];
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
        [User sharedUser].gender = [item[@"value"] integerValue];
    }];
    [picker showInView:self.view];
}

//选择出生日期
- (IBAction)chooseBornDate:(UIButton *)sender {
    LCDatePicker *datePicker = [LCDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setSelectBlock:^(NSDate *date) {
        NSLog(@"%@",date);
		NSDateFormatter *formater = [[NSDateFormatter alloc] init];
		formater.dateFormat = @"yyyy-MM-dd";
		NSString *strDate = [formater stringFromDate:date];
		[User sharedUser].bornDate = strDate;
		[sender setTitle:strDate forState:UIControlStateNormal];
    }];
    [datePicker showInView:self.view];
}

//提供身份验证
- (IBAction)idValidBtnClick:(id)sender {
    IDValidViewController *idValidVc = [IDValidViewController new];
    [self.navigationController pushViewController:idValidVc animated:YES];
}

- (void)setUsrInfo {
	User *user = [User sharedUser];
	[self.avatarImageView setImageWithURLString:user.avatarUrl andPlaceholderNamed:@"placeholder-none"];
	self.nameTextField.text = user.firstName;
	self.familyNameTextField.text = user.familyName;
	self.aboutTextField.text = user.about;
	[self.genderBtn setTitle:user.gender == 1 ? @"男" : @"女" forState:UIControlStateNormal];
	[self.bornDateBtn setTitle:user.bornDate forState:UIControlStateNormal];
	self.positionTextField.text = user.city;
	self.schoolTextField.text = user.school;
	self.jobTextField.text = user.job;
	self.languageTextField.text = user.language;
	self.emalTextField.text = user.email;
	if (user.isServer) {
		[self.validIDBtn setTitle:@"已验证" forState:UIControlStateNormal];
	}
}

- (void)saveUserInfo {
    NSDictionary *param = @{
                            @"token":[User sharedUser].token,
                            @"customerId":[User sharedUser].userId,
                            @"headImg":[User sharedUser].avatarUrl,
                            @"firstName":_nameTextField.text,
                            @"familyName":_familyNameTextField.text,
							@"about":_aboutTextField.text,
                            @"gender":[_genderBtn.titleLabel.text isEqualToString:@"男"]?@(1):@(0),
                            @"city":_positionTextField.text,
                            @"school":_schoolTextField.text,
                            @"language":_languageTextField.text,
                            @"job":_jobTextField.text,
                            @"email":_emalTextField.text
                            };
    [[CoreAPI core] POSTURLString:@"/customer" withParameters:param success:^(id ret) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSString *code, NSString *msg, id ret) {
        [SVProgressHUD showErrorWithStatus:msg];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
    }];
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
