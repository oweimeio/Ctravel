//
//  ClientOrderViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientOrderViewController.h"
#import "ClientOrderCell.h"
#import "ClientOrderListViewController.h"
#import "PreHeader.h"

@interface ClientOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ClientOrderViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ClientOrderCell" bundle:[NSBundle mainBundle
                                                                                ]] forCellReuseIdentifier:ClientOrderCellIdentifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self requestOrderListData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


//MARK: - ACTION
- (IBAction)watchDealRecordsBtnClick:(id)sender {
    [self.navigationController pushViewController:[ClientOrderListViewController new] animated:YES];
}

//MARK: - METHOD
- (void)requestOrderListData {
    NSDictionary *param = @{
                            @"token": [User sharedUser].token,
                            @"userId": [User sharedUser].userId
                            };
    [[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/orderInfoCustomer/%@", [User sharedUser].userId] withParameters:param success:^(id ret) {
        self.dataSource = ret[@"orderInfo"];
        [_tableView reloadData];
        self.emptyDataView.hidden = self.dataSource.count;
        [self.tableView.mj_header endRefreshing];
    } error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClientOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ClientOrderCellIdentifier forIndexPath:indexPath];
	__weak NSDictionary *dic = self.dataSource[indexPath.row];
	[cell.photoView setImageWithURLString:dic[@"imageUrl"] andPlaceholderNamed:@"placeholder-none"];
	cell.desLabel.text = [NSString stringWithFormat:@"%@\n@体验时间:%@\n体验价格:%@",dic[@"title"],dic[@"serviceTime"],dic[@"tradeAmount"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
