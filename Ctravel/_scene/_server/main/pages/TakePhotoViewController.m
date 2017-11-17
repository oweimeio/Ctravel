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

@property (weak, nonatomic) IBOutlet UIButton *firstPicBtn;

@property (weak, nonatomic) IBOutlet UIButton *secondPicBtn;

@property (weak, nonatomic) IBOutlet UIButton *thirdPicBtn;

@property (strong, nonatomic) UIImagePickerController *pickerController;

@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultTheme];
}

- (IBAction)picBtnClick:(UIButton *)sender {
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIImagePickerController *ip = [[UIImagePickerController alloc] init];
	
	ip.allowsEditing = NO;
	
	[ip setBk_didCancelBlock:^(UIImagePickerController *imp) {
		[imp dismissViewControllerAnimated:YES completion:nil];
	}];
	
	[ip setBk_didFinishPickingMediaBlock:^(UIImagePickerController *imp, NSDictionary *ret) {
		
		[SVProgressHUD showWithStatus:@"正在上传图片"];
		
		//UIImage *photo = [ret[UIImagePickerControllerEditedImage] resize:(CGSize){750, 750}];
		UIImage *photo = [ret objectForKey:UIImagePickerControllerOriginalImage];
		photo = [self compressImage:photo toMaxFileSize:50000];
		
		[[CoreAPI core] POSTImage:photo progress:^(float completed, float total) {
			
		} success:^(id ret) {
			
			if (sender == _firstPicBtn) {
				NSLog(@"第一張圖");
				[_firstPicBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:ret[@"url"]] placeholderImage:[UIImage imageNamed:@"placeholder-none"]];
				[Experience defaultExperience].imageUrl_main = ret[@"url"];
			}
			else if (sender == _secondPicBtn) {
				NSLog(@"第二張圖");
				[_secondPicBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:ret[@"url"]] placeholderImage:[UIImage imageNamed:@"placeholder-none"]];
				[Experience defaultExperience].imageUrl_left = ret[@"url"];
			}
			else if (sender == _thirdPicBtn) {
				[_thirdPicBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:ret[@"url"]] placeholderImage:[UIImage imageNamed:@"placeholder-none"]];
				[Experience defaultExperience].imageUrl_right = ret[@"url"];
			}
			else {
				
			}
			
			[SVProgressHUD showSuccessWithFormatStatus:@"上传成功"];
			
		} apierror:^(NSString *code, NSString *msg, id ret) {
			[SVProgressHUD showErrorWithFormatStatus:@"%@", msg];
		} failure:^(NSError *error) {
			[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
		}];
		
		[imp dismissViewControllerAnimated:YES completion:^{}];
	}];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		
		ip.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		
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


- (IBAction)preViewBtnClick:(id)sender {
    
}


- (IBAction)nextStepBtnClick:(id)sender {
    CreatePageViewController *createVc = [CreatePageViewController new];
    createVc.info = @{@"title":@"为您提供的体验设定一个适中的价格？",@"showTip":@"点击进一步了解价格",@"progress":@"0.9"};
    createVc.type = CommonDesTypePrice;
	createVc.style = CreatPageStyleWrite;
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

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
	CGFloat compression = 0.9f;
	CGFloat maxCompression = 0.1f;
	NSData *imageData = UIImageJPEGRepresentation(image, compression);
	while ([imageData length] > maxFileSize && compression > maxCompression) {
		compression -= 0.1;
		imageData = UIImageJPEGRepresentation(image, compression);
	}
	UIImage *compressedImage = [UIImage imageWithData:imageData];
	return compressedImage;
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
