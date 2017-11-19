//
//  PreViewViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PreViewViewController.h"
#import "PreHeader.h"

@interface PreViewViewController ()

@end

@implementation PreViewViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"FavDetailViewController" bundle:[NSBundle mainBundle]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    
    [self.picImageView setImageWithURLString:[dataSource[@"imageUrl"] componentsSeparatedByString:@","].firstObject andPlaceholderNamed:@"placeholder-none"];
    [self.avatarImageView setImageWithURLString:dataSource[@"headImg"] andPlaceholderNamed:@"defaultHeadImage"];
    self.simpleDesLabel.text = [NSString stringWithFormat:@"达人：%@%@\n体验类型：%@\n描述：%@\n",dataSource[@"firstName"],dataSource[@"familyName"],dataSource[@"serviceName"], dataSource[@"contentDescription"]];
    self.exContentLabel.text = dataSource[@"contentDetails"];
    self.goWhereLabel.text = dataSource[@"destination"];
    self.meetPointLabel.text = dataSource[@"rendezvous"];
    self.exHaveLabel.text = dataSource[@"contentDetails"];
    self.remarkLabel.text = dataSource[@"comment"];
    self.masterRegulationsLabel.text = dataSource[@"requirement"];
    self.exPeopleCount.text = dataSource[@"peopleNumber"];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[dataSource[@"price"] floatValue]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDataSource:_dataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//MARK: - ACTION

- (IBAction)navBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    scrollView.bounces = (scrollView.contentOffset.y <= 100) ? NO : YES;
    
    if (self.scrollView.contentOffset.y > 40) {
        self.navigationController.navigationBar.translucent = NO;
    }
    else {
        self.navigationController.navigationBar.translucent = YES;
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
