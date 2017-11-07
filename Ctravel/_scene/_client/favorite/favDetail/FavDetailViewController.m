//
//  FavDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FavDetailViewController.h"
#import "PreHeader.h"
#import "EvaluationViewController.h"
#import "WatchDateViewController.h"
#import "BuyProViewController.h"

@interface FavDetailViewController ()

@property (nonatomic)CGSize headerDefaultSize;

@property (assign, nonatomic) BOOL isHideStatusBar;

@end

@implementation FavDetailViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"FavDetailViewController" bundle:[NSBundle mainBundle]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [self.picImageView setImageWithURLString:dataSource[@"imageUrl"] andPlaceholderNamed:@"placeholder-none"];
    [self.avatarImageView setImageWithURLString:@"" andPlaceholderNamed:@"placeholder-none"];
    self.simpleDesLabel.text = [NSString stringWithFormat:@"%@\n%@\n",dataSource[@"contentDescription"], dataSource[@"contentDetails"]];
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
    
    self.headerDefaultSize = self.picImageView.frame.size;
    
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


- (IBAction)watchExMasterDate:(id)sender {
    WatchDateViewController *watchVc = [WatchDateViewController new];
	watchVc.expId = _dataSource[@"experienceId"];
    [self.navigationController pushViewController:watchVc animated:YES];
}

- (IBAction)watchEvaluation:(id)sender {
    EvaluationViewController *evaVc = [EvaluationViewController new];
	evaVc.expId = _dataSource[@"experienceId"];
    [self.navigationController pushViewController:evaVc animated:YES];
}

- (IBAction)connectMaster:(id)sender {
	
}
//预定
- (IBAction)reserveBtnClick:(id)sender {
    //选择时间
	
    
    NSDictionary *param = @{
                             @"experienceId":_dataSource[@"experienceId"],
                             @"userId":[User sharedUser].userId,
                             @"token":[User sharedUser].token,
                             @"serviceTimeId":@"333"
                             };
    [[CoreAPI core] GETURLString:@"/pay/reserve/2345678" withParameters:param success:^(id ret) {
        NSLog(@"%@",ret);
        BuyProViewController *buyVc = [[BuyProViewController alloc] init];
        buyVc.dataSource = ret[@""];
        [self.navigationController pushViewController:buyVc animated:YES];
        
    } error:^(NSString *code, NSString *msg, id ret) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (BOOL)prefersStatusBarHidden {
    return self.isHideStatusBar;
}

- (void)hideStatusBar:(BOOL)hide {
    self.isHideStatusBar = hide;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
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
