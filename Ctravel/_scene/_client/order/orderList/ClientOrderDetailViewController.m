//
//  ClientOrderDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientOrderDetailViewController.h"
#import "PreHeader.h"

@interface ClientOrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rendezvousLabel;
@property (weak, nonatomic) IBOutlet UILabel *exDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

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
    [_imageView setImageWithURLString:_dataSource[@""] andPlaceholderNamed:@"placeholder-none"];
    _nameLabel.text = _dataSource[@""];
    _priceLabel.text = _dataSource[@""];
    _rendezvousLabel.text = _dataSource[@""];
    _exDateLabel.text = _dataSource[@""];
    //根据状态设置btn的文字信息
}

- (IBAction)cancelBtnClick:(id)sender {
    
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
