//
//  ClientCompleteViewController.m
//  Ctravel
//
//  Created by apple on 2017/10/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientCompleteViewController.h"
#import "ClientOrderCell.h"

@interface ClientCompleteViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ClientCompleteViewController

- (NSArray *)dataSource {
	if (!_dataSource) {
		_dataSource = @[];
	}
	return _dataSource;
}

- (instancetype)init {
	if (self = [super initWithNibName:@"ClientCompleteViewController" bundle:nil]) {
		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"ClientOrderCell" bundle:[NSBundle mainBundle
                                                                                 ]] forCellReuseIdentifier:ClientOrderCellIdentifier];
	
	self.tableView.tableFooterView = [UIView new];
	
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (_type == OrderTypeCompleted) {
            [self requestOrderListDataWithState:2];
        }
        else {
            [self requestOrderListDataWithState:1];
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
	
}

//MARK: - METHOD
//MARK: - METHOD
- (void)requestOrderListDataWithState:(NSInteger)state {
    NSDictionary *param = @{
                            @"token": [User sharedUser].token,
                            @"userId": [User sharedUser].userId,
                            @"tradeStatus":@(state)
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
    cell.desLabel.text = [NSString stringWithFormat:@"%@\n体验时间:%@\n预定时间:%@\n体验价格:%@",dic[@"title"],dic[@"serviceDate"],[[NSDate dateWithTimeIntervalSince1970:[dic[@"createTime"] doubleValue]/1000] stringWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI],dic[@"tradeAmount"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClientOrderDetailViewController *detailVc = [[ClientOrderDetailViewController alloc] init];
    __weak NSDictionary *dic = self.dataSource[indexPath.row];
    detailVc.dataSource = dic;
    [self.navigationController pushViewController:detailVc animated:YES];
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
