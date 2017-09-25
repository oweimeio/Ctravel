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

@interface CreatePageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *selectViewTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectViewBtn;

@property (weak, nonatomic) IBOutlet UITextView *writeTextView;

@property (weak, nonatomic) IBOutlet UIView *operationView;
@property (weak, nonatomic) IBOutlet UIButton *preViewBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property (weak, nonatomic) IBOutlet UIView *showTipView;

@property (weak, nonatomic) IBOutlet UILabel *showTipTitleLabel;


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
    
}

- (void)setStyle:(CreatPageStyle)style {
    _style = style;
    switch (style) {
        case CreatPageStyleSelect: {
            self.selectViewHeight.constant = 100;
            self.writeTextView.hidden = YES;
        }   break;
        case CreatPageStyleWrite: {
            self.selectViewHeight.constant = 0;
            self.writeTextView.hidden = NO;
        }
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultTheme];
    
    [self setInfo:_info];
    
    [self setStyle:_style];
}

//MARK: - ACTION

- (IBAction)selectViewBtnClick:(id)sender {
}


- (IBAction)preViewBtnClick:(id)sender {
}

- (IBAction)nextStepBtnClick:(id)sender {
}

- (IBAction)showTipViewPress:(id)sender {
    CommonDesViewController *commonVc = [CommonDesViewController new];
    commonVc.type = CommonDesTypeStyle;
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
