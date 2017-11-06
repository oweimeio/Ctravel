//
//  ServerMessageViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerMessageViewController.h"
#import "PreHeader.h"
#import "ClientMsgCell.h"

@interface ServerMessageViewController ()

@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *msgTableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@end

@implementation ServerMessageViewController

- (NSArray *)dataSource {
	if (!_dataSource) {
		_dataSource = @[@{@"isRead":@"1",@"avatarUrl":@"",
						  @"name":@"王者",@"content":@"顺丰到付地方的发"}];
	}
	return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.msgTableView.tableFooterView = [UIView new];
	
	self.msgTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
		[self requestMsgData:NO];
	}];
	
	self.msgTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		[self requestMsgData:YES];
	}];
	
	[self.msgTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)requestMsgData:(BOOL)paging {
	NSInteger pageSize = 10;
	NSDictionary *param = @{
							@"token": [User sharedUser].token,
							@"customerId": [User sharedUser].userId,
							@"pageNumber" : paging ? @(self.dataSource.count / pageSize + 1) : @1,
							@"pageSize": @(pageSize)
							};
	[[CoreAPI core] GETURLString:@"/message" withParameters:param success:^(id ret) {
		self.dataSource = ret[@"messageList"];
		[_msgTableView reloadData];
		self.emptyDataView.hidden = self.dataSource.count;
		[_msgTableView.mj_header endRefreshing];
		[_msgTableView.mj_footer endRefreshing];
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
		[_msgTableView.mj_header endRefreshing];
		[_msgTableView.mj_footer endRefreshing];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
		[_msgTableView.mj_header endRefreshing];
		[_msgTableView.mj_footer endRefreshing];
	}];
}

//MARK: - TABLEDELEGATE & DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ClientMsgCell *cell = [ClientMsgCell clientMsgCellInTableView:tableView];
	cell.dataSource = self.dataSource[indexPath.row];
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
