//
//  PublishViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PublishViewController.h"
#import "PreHeader.h"

@interface PublishViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.photoView setImageWithURLString:[Experience defaultExperience].imageUrl_main andPlaceholderNamed:@"placeholder-none"];
}

//预览
- (IBAction)preViewBtnClick:(id)sender {
	
}

//发布
- (IBAction)publishBtnClick:(id)sender {
    [SVProgressHUD showSuccessWithStatus:@"发布成功,请设置您的体验日期"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    return;
    Experience * exVc = [Experience defaultExperience];
    NSLog(@"%@",exVc);
    NSDictionary *params = @{
                             @"token":[User sharedUser].token,
                             @"customerId":[User sharedUser].userId,
                             @"title":exVc.title,
                             @"contentDescription":exVc.contentDes,
                             @"destination":exVc.destination,
                             @"rendezvous":exVc.rendezvous,
                             @"contentDetails":exVc.mustKnow,
                             @"comment":exVc.mark,
                             @"requirement":exVc.requirement,
                             @"peopleNumber":@(exVc.peopleCount),
                             @"currencyType":!exVc.currencyType ? @"" : exVc.currencyType,
                             @"price":@(exVc.price),
                             @"imageUrl":!exVc.imageUrl_main? @"" : exVc.imageUrl_main
                             };
    [[CoreAPI core] GETURLString:@"/experience/experiences" withParameters:params success:^(id ret) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功,请设置您的体验日期"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(NSString *code, NSString *msg, id ret) {
        
    } failure:^(NSError *error) {
        
    }];
    
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
