//
//  HelpViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HelpViewController.h"
#import "PreHeader.h"

@interface HelpViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *textPlaceholder;

@end

@implementation HelpViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"HelpViewController" bundle:nil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	switch (_type) {
		case CommentTypeForOrder: {
			_titleLabel.text = @"您对此次活动的评价";
		}	break;
		case CommentTypeForPlatform: {
			
		}	break;
		default:
			break;
	}
    
    [self.view bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
}

- (IBAction)submitBtnClick:(id)sender {
	switch (_type) {
		case CommentTypeForOrder: {
			if (!_serverCustomerId || !_experienceId) {
				return;
			}
			NSDictionary *params = @{
									 @"customerId": _serverCustomerId,
									 @"commentContent": _textView.text,
									 @"token": [User sharedUser].token,
									 @"experienceId": _experienceId
									 };
			[[CoreAPI core] POSTURLString:@"/comment/comments" withParameters:params success:^(id ret) {
				[SVProgressHUD showSuccessWithStatus:@"评论成功"];
				[self.navigationController popViewControllerAnimated:YES];
			} error:^(NSString *code, NSString *msg, id ret) {
				[SVProgressHUD showErrorWithStatus:msg];
			} failure:^(NSError *error) {
				[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
			}];
		}	break;
		case CommentTypeForPlatform: {
			[SVProgressHUD showSuccessWithStatus:@"感谢您的宝贵意见！"];
		}	break;
		default:
			[SVProgressHUD showSuccessWithStatus:@"感谢您的宝贵意见！"];
			break;
	}
	
}


- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _textPlaceholder.text = @"";
        if (textView.text.length >255) {
            textView.text = [textView.text substringToIndex:255];
        }
    }
    else {
        _textPlaceholder.text = @"您的意见";
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        /// 调用你需要处理的事情  ///
        return NO;
    }
    return YES;
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
