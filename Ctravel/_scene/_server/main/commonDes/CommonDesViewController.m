//
//  CommonDesViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommonDesViewController.h"

@interface CommonDesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contenLabel;

@end

@implementation CommonDesViewController

- (void)setType:(CommonDesType)type {
    _type = type;
    switch (type) {
        case CommonDesTypeStyle:
            _titleLabel.text = @"风格意义";
            _contenLabel.text = @"选择一个最能描述您的旅程体验的类别";
            break;
        case CommonDesTypeCity:
            _titleLabel.text = @"城市";
            _contenLabel.text = @"输入一个您想提供体验的城市";
            break;
        case CommonDesTypeTitle:
            _titleLabel.text = @"标题";
            _contenLabel.text = @"输入一个您觉得酷炫的标题";
            break;
        case CommonDesTypeDes:
            _titleLabel.text = @"行程描述";
            _contenLabel.text = @"输入您的行程安排";
            break;
        case CommonDesTypeAddress:
            _titleLabel.text = @"地点";
            _contenLabel.text = @"列出要去的地点";
            break;
        case CommonDesTypeMustKnow:
            _titleLabel.text = @"须知";
            _contenLabel.text = @"您需要自己安排的内容";
            break;
        case CommonDesTypeMark:
            _titleLabel.text = @"注明";
            _contenLabel.text = @"您可以注明体验包含的项目要点";
            break;
        case CommonDesTypeRequire:
            _titleLabel.text = @"要求";
            _contenLabel.text = @"您对参与者有什么不错的要求";
            break;
        case CommonDesTypePlace:
            _titleLabel.text = @"集合点";
            _contenLabel.text = @"在什么地方集合";
            break;
        case CommonDesTypeTime:
            _titleLabel.text = @"活动时间";
            _contenLabel.text = @"输入一个默认的时间";
            break;
        case CommonDesTypePeopleCount:
            _titleLabel.text = @"参与人数";
            _contenLabel.text = @"参与活动的最多人数";
            break;
        case CommonDesTypePrice:
            _titleLabel.text = @"价格";
            _contenLabel.text = @"设定体验价格";
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setType:_type];
}

//MARK: - ACTION

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
