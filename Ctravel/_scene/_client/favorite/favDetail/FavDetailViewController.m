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

@interface FavDetailViewController () <ChooseDateDelegate> {
    NSString *serviceDateId;
}

@property (nonatomic)CGSize headerDefaultSize;

@property (assign, nonatomic) BOOL isHideStatusBar;

@property (nonatomic, strong) UIBarButtonItem *rightBarItem;

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
    
    [self.picImageView setImageWithURLString:[dataSource[@"imageUrl"] componentsSeparatedByString:@","].firstObject andPlaceholderNamed:@"placeholder-none"];
    [self.avatarImageView setImageWithURLString:dataSource[@"headImg"] andPlaceholderNamed:@"defaultHeadImage"];
    self.simpleDesLabel.text = [NSString stringWithFormat:@"达人：%@%@\n体验类型：%@\n描述：%@\n",!dataSource[@"familyName"]?@"":dataSource[@"familyName"],!dataSource[@"firstName"]?@"":dataSource[@"firstName"],!dataSource[@"serviceName"]?@"":dataSource[@"serviceName"], !dataSource[@"contentDescription"]?@"":dataSource[@"contentDescription"]];
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
	
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"empty-heart"] style:UIBarButtonItemStyleDone handler:^(id sender) {
        //收藏或取消当前体验
        if ([_dataSource[@"isFavourite"] isEqualToString:@"1"]) {
            NSDictionary *param = @{
                                    @"token":[User sharedUser].token,
                                    @"customerId":[User sharedUser].userId,
                                    @"experienceId":_dataSource[@"experienceId"]
                                    };
            [[CoreAPI core] POSTURLString:@"/experience/cancelFavorite" withParameters:param success:^(id ret) {
                _rightBarItem.image = [UIImage imageNamed:@"empty-heart"];
                self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
            } error:^(NSString *code, NSString *msg, id ret) {
                [SVProgressHUD showErrorWithStatus:msg];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
            }];
        }
        else {
            NSDictionary *param = @{
                                    @"token":[User sharedUser].token,
                                    @"customerId":[User sharedUser].userId,
                                    @"experienceId":_dataSource[@"experienceId"]
                                    };
            [[CoreAPI core] POSTURLString:@"/experience/favorite" withParameters:param success:^(id ret) {
                _rightBarItem.image = [UIImage imageNamed:@"solid-heart"];
                self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            } error:^(NSString *code, NSString *msg, id ret) {
                [SVProgressHUD showErrorWithStatus:msg];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
            }];
        }
    }];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    _rightBarItem = rightBarItem;
    if ([_dataSource[@"isFavourite"] isEqualToString:@"1"]) {
        _rightBarItem.image = [UIImage imageNamed:@"solid-heart"];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    }
    else {
        _rightBarItem.image = [UIImage imageNamed:@"empty-heart"];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor darkGrayColor];
    }
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
    watchVc.delegate = self;
	watchVc.expId = _dataSource[@"experienceId"];
    watchVc.serverId = !_dataSource[@"customerId"]?@"":_dataSource[@"customerId"];
    [self.navigationController pushViewController:watchVc animated:YES];
}

- (IBAction)watchEvaluation:(id)sender {
    EvaluationViewController *evaVc = [EvaluationViewController new];
	evaVc.expId = _dataSource[@"experienceId"];
    [self.navigationController pushViewController:evaVc animated:YES];
}

//联络达人
- (IBAction)connectMaster:(id)sender {
	RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
	conversationVC.conversationType = ConversationType_PRIVATE;
	conversationVC.targetId = _dataSource[@"customerId"]; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
	conversationVC.title = [NSString stringWithFormat:@"%@%@",_dataSource[@"familyName"],_dataSource[@"firstName"]];
	[self.navigationController pushViewController:conversationVC animated:YES];
}
//预定
- (IBAction)reserveBtnClick:(id)sender {
    //选择时间
    if ([serviceDateId isEmpty]) {
        [SVProgressHUD showErrorWithStatus:@"请选择体验时间"];
        return;
    }
    
    NSDictionary *param = @{
                             @"experienceId":_dataSource[@"experienceId"],
                             @"userId":[User sharedUser].userId,
                             @"token":[User sharedUser].token,
                             @"serviceTimeId":serviceDateId
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


- (void)chooseDate:(NSString *)date andDateId:(NSString *)dateId {
    serviceDateId = dateId;
	_dateLabel.text = date;
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
