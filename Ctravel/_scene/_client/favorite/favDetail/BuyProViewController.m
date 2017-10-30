//
//  BuyProViewController.m
//  Ctravel
//
//  Created by apple on 2017/10/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BuyProViewController.h"
#import "PreHeader.h"
#import <Pingpp.h>

@interface BuyProViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation BuyProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)reserveBtnClick:(id)sender {
    NSDictionary *params = @{
                             @"userId":[User sharedUser].userId,
                             @"token":[User sharedUser].token
                             };
    [[CoreAPI core] GETURLString:@"/pay/pay/150866062587490952" withParameters:params success:^(id ret) {
        NSLog(@"%@",ret);
        [Pingpp createPayment:ret[@"charge"] appURLScheme:@"com.ctravelApp.www" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"%@",result);
        }];
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
