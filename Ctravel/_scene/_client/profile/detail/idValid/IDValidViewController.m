//
//  IDValidViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IDValidViewController.h"
#import "PreHeader.h"

@interface IDValidViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *idCardImage;

@end

@implementation IDValidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	if ([User sharedUser].idCardImageUrl) {
		[_idCardImage setImageWithURLString:[User sharedUser].idCardImageUrl andPlaceholderNamed:@"placeholder-none"];
	}
}

- (IBAction)uploadIDCard:(id)sender {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIImagePickerController *ip = [[UIImagePickerController alloc] init];
	
	ip.allowsEditing = YES;
	
	[ip setBk_didCancelBlock:^(UIImagePickerController *imp) {
		[imp dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[ip setBk_didFinishPickingMediaBlock:^(UIImagePickerController *imp, NSDictionary *ret) {
		
		[SVProgressHUD showWithStatus:@"正在上传身份证"];
		
		UIImage *photo = [ret[UIImagePickerControllerEditedImage] resize:(CGSize){750, 750}];
		
		[[CoreAPI core] POSTImage:photo progress:^(float completed, float total) {
			
		} success:^(id ret) {
			[_idCardImage setImageWithURLString:ret[@"url"] andPlaceholderNamed:@"placeholder-none"];
			[User sharedUser].idCardImageUrl = ret[@"url"];
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
