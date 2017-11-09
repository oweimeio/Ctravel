//
//  CreatePageViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CreatePageViewController.h"
#import "PreHeader.h"
#import "CommonDesViewController.h"
#import "TakePhotoViewController.h"
#import "PublishViewController.h"

@interface CreatePageViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *selectViewTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectViewBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseTimeViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *writeContentTextField;

@property (weak, nonatomic) IBOutlet UITextView *writeTextView;

@property (weak, nonatomic) IBOutlet UILabel *writeViewPlaceholderLabel;

@property (weak, nonatomic) IBOutlet UIView *operationView;

@property (weak, nonatomic) IBOutlet UIButton *preViewBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property (weak, nonatomic) IBOutlet UIView *showTipView;

@property (weak, nonatomic) IBOutlet UILabel *showTipTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;

@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;

//下拉选择
@property (strong, nonatomic) NSArray *serviceTypeData;

@end

@implementation CreatePageViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"CreatePageViewController" bundle:[NSBundle mainBundle]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)setInfo:(NSDictionary *)info {
    _info = info;
    self.titleLabel.text = info[@"title"];
    self.selectViewTitleLabel.text = info[@"selectTitle"];
    [self.selectViewBtn setTitle:info[@"selectBtnTitle"] forState:UIControlStateNormal];
    self.showTipTitleLabel.text = info[@"showTip"];
}

- (void)setStyle:(CreatPageStyle)style {
    _style = style;
	self.chooseTimeViewHeight.constant = 0;
    switch (style) {
        case CreatPageStyleSelect: {
            self.selectViewHeight.constant = 100;
            self.writeTextView.hidden = YES;
            self.selectViewBtn.hidden = NO;
            self.writeContentTextField.hidden = YES;
            self.writeViewPlaceholderLabel.hidden = YES;
        }   break;
        case CreatPageStyleWrite: {
            self.selectViewHeight.constant = 100;
            self.writeTextView.hidden = YES;
            self.selectViewBtn.hidden = YES;
            self.writeContentTextField.hidden = NO;
            self.writeViewPlaceholderLabel.hidden = YES;
        }   break;
        case CreatPageStyleWriteDes: {
            self.selectViewHeight.constant = 0;
            self.writeTextView.hidden = NO;
            self.writeViewPlaceholderLabel.hidden = NO;
        }   break;
		case CreatPageStyleChooseTime: {
			self.chooseTimeViewHeight.constant = 50;
			self.selectViewHeight.constant = 0;
			self.writeTextView.hidden = YES;
			self.writeViewPlaceholderLabel.hidden = YES;
			break;
		}
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultTheme];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        if (_type == CommonDesTypePrice) {
            [Experience defaultExperience].price = [self.writeContentTextField.text floatValue];
        }
        [Experience saveExperienceDataWithUID:[User sharedUser].userId];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }];
    
    [self.view bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
    
    [self setInfo:_info];
    
    [self setStyle:_style];
    
    [self setDefaultValueWithType:_type];
}

//MARK: - ACTION

- (IBAction)selectViewBtnClick:(UIButton *)sender {
    //根据type传递不同的DataSource
    if (_type == CommonDesTypeStyle) {
        LYPicker *picker = [[LYPicker alloc] init];
        picker.keyTitle = @"serviceName";
        picker.datasource = self.serviceTypeData;
        [picker setSelectBlock:^(NSInteger idx, NSDictionary *item) {
            [sender setTitle:item[@"serviceName"] forState:UIControlStateNormal];
            [Experience defaultExperience].style = item[@"serviceName"];
            [Experience defaultExperience].styleId = item[@"serviceTypeId"];
        }];
        [picker showInView:self.view];
    }
}

//选择开始时间
- (IBAction)chooseStartTime:(UIButton *)sender {

	LYDatePicker *picker = [[LYDatePicker alloc] init];
	[picker setSelectBlock:^(NSDate *date) {
		NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
		selectDateFormatter.dateFormat = @"HH:mm"; // 设置时间和日期的格式
		NSString *dateAndTime = [selectDateFormatter stringFromDate:date];
		[sender setTitle:dateAndTime forState:UIControlStateNormal];
		[Experience defaultExperience].defaultTimeStart = dateAndTime;
	}];
	[picker showInView:self.view];
}

//选择结束时间
- (IBAction)chooseEndTime:(UIButton *)sender {
	LYDatePicker *picker = [[LYDatePicker alloc] init];
	[picker setSelectBlock:^(NSDate *date) {
		NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
		selectDateFormatter.dateFormat = @"HH:mm"; // 设置时间和日期的格式
		NSString *dateAndTime = [selectDateFormatter stringFromDate:date];
		[sender setTitle:dateAndTime forState:UIControlStateNormal];
		[Experience defaultExperience].defaultTimeEnd = dateAndTime;
	}];
	[picker showInView:self.view];
}

// 预览
- (IBAction)preViewBtnClick:(id)sender {
    Experience *experience = [Experience defaultExperience];
    NSLog(@"style=%@",experience.style);
    NSLog(@"city=%@",experience.city);
    NSLog(@"title=%@",experience.title);
}

// 下一步
- (IBAction)nextStepBtnClick:(id)sender {
    CreatePageViewController *createVc = [CreatePageViewController new];
    Experience *experience = [Experience defaultExperience];
    switch (_type) {
        case CommonDesTypeStyle: {
			if ([self.selectViewBtn.titleLabel.text isEqualToString:@"户外体验（选择）"] || ![Experience getExperienceDataWithUID:[User sharedUser].userId].style) {
                [SVProgressHUD showErrorWithStatus:@"请填写体验风格"];
                return;
            }
            createVc.info = @{@"title":@"您打算在哪座城市提供体验？",@"selectTitle":@"城市",@"showTip":@"点击进一步了解城市提供"};
            createVc.style = CreatPageStyleWrite;
            createVc.type = CommonDesTypeCity;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeCity: {
            experience.city = self.writeContentTextField.text;
            createVc.info = @{@"title":@"为您的体验起了简短但吸引眼球的名称",@"selectTitle":@"标题",@"showTip":@"点击进一步了解标题"};
            createVc.style = CreatPageStyleWrite;
            createVc.type = CommonDesTypeTitle;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeTitle: {
            experience.title = self.writeContentTextField.text;
            createVc.info = @{@"title":@"告诉参与者我们要做些什么？（描述您行程安排）",@"showTip":@"点击进一步了解要做些什么"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypeDes;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeDes: {
			experience.contentDes = self.writeTextView.text;
            createVc.info = @{@"title":@"向参与者描述一下要去何处（列出要去的点，不要包括详细地址）",@"showTip":@"点击进一步了解地点"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypeAddress;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeAddress: {
			experience.destination = self.writeTextView.text;
            createVc.info = @{@"title":@"注明体验包含的项目（门票、交通、餐费）",@"showTip":@"点击进一步了解注明"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypeMark;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeMark: {
			experience.mark = self.writeTextView.text;
            createVc.info = @{@"title":@"告诉参与者还需要知道些什么？（需要携带或自己安排）",@"showTip":@"点击进一步了解须知"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypeMustKnow;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeMustKnow: {
			experience.mustKnow = self.writeTextView.text;
            createVc.info = @{@"title":@"您对参与者的要求？（年龄限制、体验需要的基本技能）",@"showTip":@"点击进一步了解要求"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypeRequire;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeRequire: {
			experience.requirement = self.writeTextView.text;
            createVc.info = @{@"title":@"您打算在哪里与参与者集合？",@"showTip":@"点击进一步了解集合"};
            createVc.style = CreatPageStyleWriteDes;
            createVc.type = CommonDesTypePlace;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypePlace: {
			experience.rendezvous = self.writeTextView.text;
            createVc.info = @{@"title":@"您的活动默认时间？",@"showTip":@"点击进一步了解时间"};
            createVc.style = CreatPageStyleChooseTime;
            createVc.type = CommonDesTypeTime;
            [self.navigationController pushViewController: createVc animated:YES];
        }   break;
        case CommonDesTypeTime: {
            if ([self.startTimeBtn.titleLabel.text isEqualToString:@"选择开始时间"]) {
                [SVProgressHUD showErrorWithStatus:@"请选择默认开始时间"];
                return;
            }
            else if ([self.endTimeBtn.titleLabel.text isEqualToString:@"选择结束时间"]) {
                [SVProgressHUD showErrorWithStatus:@"请选择默认结束时间"];
                return;
            }
            TakePhotoViewController *photoVc = [TakePhotoViewController new];
			
            [self.navigationController pushViewController: photoVc animated:YES];
        }   break;
        case CommonDesTypePic: {
			
        }   break;
        case CommonDesTypePrice: {
			if (self.writeContentTextField.text.length == 0) {
				[SVProgressHUD showErrorWithStatus:@"请设置此次活动的价格"];
				return;
			}
			experience.price = [self.writeContentTextField.text floatValue];
			PublishViewController *publishVc = [PublishViewController new];
			[self.navigationController pushViewController:publishVc animated:YES];

        }   break;
        default:
            break;
    }
}

- (IBAction)showTipViewPress:(id)sender {
    CommonDesViewController *commonVc = [CommonDesViewController new];
    commonVc.type = _type;
    [self presentViewController:commonVc animated:YES completion:nil];
}

//MARK: - METHOD
- (void)setDefaultTheme {
    self.preViewBtn.layer.borderWidth = 2;
    self.preViewBtn.layer.borderColor = [[UIColor colorWithHex:@"1890B5" andAlpha:1] CGColor];
    self.preViewBtn.layer.cornerRadius = 5;
    self.preViewBtn.layer.masksToBounds = YES;
    self.nextStepBtn.layer.cornerRadius = 5;
    self.nextStepBtn.layer.masksToBounds = YES;
}

- (void)setDefaultValueWithType:(CommonDesType)type {
    Experience *experience = [Experience getExperienceDataWithUID:[User sharedUser].userId];
    switch (type) {
        case CommonDesTypeStyle: {
            NSDictionary *param = @{
                                    @"customerId" : [User sharedUser].userId,
                                    @"token" : [User sharedUser].token
                                    };
            [[CoreAPI core] GETURLString:@"/experience/serviceType" withParameters:param success:^(id ret) {
                self.serviceTypeData = ret[@"serviceTypeDetail"];
            } error:^(NSString *code, NSString *msg, id ret) {
                [SVProgressHUD showErrorWithStatus:msg];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
            }];
            
            NSLog(@"%@",experience.style);
            if (experience.style) {
                [_selectViewBtn setTitle:experience.style forState:UIControlStateNormal];
            }
        }   break;
        case CommonDesTypeCity: {
            if (experience.city) {
                _writeContentTextField.text = experience.city;
            }
        }   break;
        case CommonDesTypeTitle: {
            if (experience.title) {
                _writeContentTextField.text = experience.title;
            }
        }   break;
        case CommonDesTypeDes: {
            if (experience.contentDes) {
                _writeTextView.text = experience.contentDes;
                self.writeViewPlaceholderLabel.text = @"";
            }
        }   break;
        case CommonDesTypeAddress: {
            if (experience.destination) {
                _writeTextView.text = experience.destination;
                self.writeViewPlaceholderLabel.text = @"";
            }
        }   break;
        case CommonDesTypeMark: {
			if (experience.mark) {
				_writeTextView.text = experience.mark;
                self.writeViewPlaceholderLabel.text = @"";
			}
        }   break;
        case CommonDesTypeMustKnow: {
			if (experience.mustKnow) {
				_writeTextView.text = experience.mustKnow;
                self.writeViewPlaceholderLabel.text = @"";
			}
        }   break;
        case CommonDesTypeRequire: {
			if (experience.requirement) {
				_writeTextView.text = experience.requirement;
                self.writeViewPlaceholderLabel.text = @"";
			}
        }   break;
        case CommonDesTypePlace: {
			if (experience.rendezvous) {
				_writeTextView.text = experience.rendezvous;
                self.writeViewPlaceholderLabel.text = @"";
			}
        }   break;
        case CommonDesTypeTime: {
			if (experience.defaultTimeStart) {
				[_startTimeBtn setTitle:experience.defaultTimeStart forState:UIControlStateNormal];
			}
			if (experience.defaultTimeEnd) {
				[_endTimeBtn setTitle:experience.defaultTimeEnd forState:UIControlStateNormal];
			}
        }   break;
        case CommonDesTypePic: {
			//在照片页面设置
        }   break;
        case CommonDesTypePrice: {
			if (experience.price) {
				_writeContentTextField.text = [NSString stringWithFormat:@"%.2f", experience.price];
			}
			_writeContentTextField.placeholder = @"请输入价格";
			_writeContentTextField.keyboardType = UIKeyboardTypeNumberPad;
        }   break;
        default:
            break;
    }

}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.writeViewPlaceholderLabel.text = @"";
        if (textView.text.length > 1000) {
            textView.text = [textView.text substringToIndex:1000];
        }
    }
    else {
        self.writeViewPlaceholderLabel.text = @"多行输入";
    }
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
