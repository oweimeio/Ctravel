//
//  IncomeViewController.m
//  Ctravel
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IncomeViewController.h"
#import "PreHeader.h"

@interface IncomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalIncomeLabel;

@end

@implementation IncomeViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"IncomeViewController" bundle:nil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	//获取总收入
	[self requestIncomeData];
}

- (void)requestIncomeData {
	_totalIncomeLabel.text = @"0元";
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
