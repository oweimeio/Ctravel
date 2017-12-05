//
//  ServerOrderDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/12/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerOrderDetailViewController.h"
#import "PreHeader.h"

@interface ServerOrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *exTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *reciveBtn;

@end

@implementation ServerOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_type == OrderTypeCompleted) {
        
    }
    else if (_type == OrderTypeFuture){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"拒绝预定" style:(UIBarButtonItemStylePlain) handler:^(id sender) {
            
        }];
    }
    
    [self setUp];
}

- (IBAction)reviceBtnClick:(id)sender {
    if (_type == OrderTypeCompleted) {//发飙评论
        
    }
    else if (_type == OrderTypeFuture){//接受预定
        
    }
}

- (void)setUp {
    [_avatarImageView setImageWithURLString:_dataSource[@""] andPlaceholderNamed:@"placeholder-none"];
    _nameLabel.text = [NSString stringWithFormat:@"%@%@",_dataSource[@""], _dataSource[@""]];
    _exTimeLabel.text = _dataSource[@""];
    _orderTimeLabel.text = _dataSource[@""];
    _priceLabel.text = _dataSource[@""];
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
