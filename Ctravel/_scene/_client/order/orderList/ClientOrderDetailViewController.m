//
//  ClientOrderDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientOrderDetailViewController.h"

@interface ClientOrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rendezvousLabel;
@property (weak, nonatomic) IBOutlet UILabel *exDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (assign, nonatomic) NSInteger btnStatus;

@end

@implementation ClientOrderDetailViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"ClientOrderDetailViewController" bundle:nil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //orderId
    [self setUpWithDic:_dataSource];
    
//    NSDictionary *params = @{
//                             @"token": [User sharedUser].token,
//                             @"customerId": [User sharedUser].userId
//                             };
//    [[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/orderInfo/%@", _dataSource[@"orderId"]]withParameters: params success:^(id ret) {
//        NSDictionary *dic = ret;
//        [self setUpWithDic:dic];
//    } error:^(NSString *code, NSString *msg, id ret) {
//        [SVProgressHUD showErrorWithStatus:msg];
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
//    }];
}

- (void)setUpWithDic: (NSDictionary *)dic {
    [_imageView setImageWithURLString:_dataSource[@"imageUrl"] andPlaceholderNamed:@"placeholder-none"];
    _nameLabel.text = _dataSource[@"title"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _dataSource[@"tradeAmount"]];
    _rendezvousLabel.text = _dataSource[@"destination"];
    _exDateLabel.text = _dataSource[@"serviceDate"];
     //根据状态设置btn的文字信息
    NSInteger status = [_dataSource[@"tradeStatus"] integerValue];
    _btnStatus = status;
    switch (status) {
        case 0: //未完成
        case 1://待支付
            [_cancelBtn setTitle:@"取消预定" forState:UIControlStateNormal];
            break;
        case 2://已完成
            [_cancelBtn setTitle:@"发表评论" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)cancelBtnClick:(id)sender {
    //取消或发表评论
    switch (_btnStatus) {
        case 0: //未完成
        case 1: //待支付
			
			[SVProgressHUD showSuccessWithStatus:@"取消预订"];
            break;
        case 2: {//已完成
			HelpViewController *helpVc = [HelpViewController new];
			helpVc.type = CommentTypeForOrder;
			helpVc.serverCustomerId = _dataSource[@"customerId"];
			helpVc.experienceId = _dataSource[@"experienceId"];
			[self.navigationController pushViewController:helpVc animated:YES];
        } break;
        default:
            break;
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
