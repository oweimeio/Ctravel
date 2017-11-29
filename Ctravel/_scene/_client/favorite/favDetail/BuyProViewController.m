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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation BuyProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.imageView setImageWithURLString:[_dataSource[@"imageUrl"] componentsSeparatedByString:@","].firstObject andPlaceholderNamed:@"placeholder-none"];
    _desLabel.text = [NSString stringWithFormat:@"标题：%@\n达人：%@%@\n体验类型：%@\n描述：%@\n",_dataSource[@"title"],!_dataSource[@"familyName"]?@"":_dataSource[@"familyName"],!_dataSource[@"firstName"]?@"":_dataSource[@"firstName"],!_dataSource[@"serviceName"]?@"":_dataSource[@"serviceName"], !_dataSource[@"contentDescription"]?@"":_dataSource[@"contentDescription"]];
    self.dateLabel.text = _date;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.0f",[_dataSource[@"price"] floatValue]];
}

- (IBAction)reserveBtnClick:(id)sender {
    //
    NSDictionary *params = @{
                             @"userId":[User sharedUser].userId,
                             @"token":[User sharedUser].token
                             };
    [[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/pay/%@",_orderId] withParameters:params success:^(id ret) {
        NSLog(@"%@",ret);
        [Pingpp createPayment:ret[@"charge"] appURLScheme:@"com.ctravelApp.www" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"AAAA===%@",result);
        }];
    } error:^(NSString *code, NSString *msg, id ret) {
        [SVProgressHUD showErrorWithStatus:msg];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
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
