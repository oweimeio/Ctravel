//
//  ServerOrderHistoryListViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerOrderHistoryListViewController.h"
#import "PreHeader.h"
#import "ServerOrderCell.h"

@interface ServerOrderHistoryListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ServerOrderHistoryListViewController

- (NSArray *)dataSource {
	if (!_dataSource) {
		_dataSource = @[];
	}
	return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self.tableView registerNib:[UINib nibWithNibName:@"ServerOrderCell" bundle:[NSBundle mainBundle
																				 ]] forCellReuseIdentifier:ServerOrderCellIdentifier];
	
	self.tableView.tableFooterView = [UIView new];
	
	if (_type == OrderTypeCompleted) {
		self.view.backgroundColor = [UIColor redColor];
		self.emptyDataView.hidden = YES;
	}
	else {
		self.view.backgroundColor = [UIColor blueColor];
		self.emptyDataView.hidden = NO;
	}
	
	[self requestOrderListData];
}

//MARK: - METHOD
- (void)requestOrderListData {
	NSDictionary *param = @{
							@"token": [User sharedUser].token,
							@"userId": [User sharedUser].userId,
							};
	[[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/orderInfoCustomer/%@", [User sharedUser].userId] withParameters:param success:^(id ret) {
		self.dataSource = ret[@"orderInfo"];
		[_tableView reloadData];
		self.emptyDataView.hidden = self.dataSource.count;
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:@"网络连接错误"];
	}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ServerOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ServerOrderCellIdentifier forIndexPath:indexPath];
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
