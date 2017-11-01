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
	
	//请求消息数据
	[self requestMsgData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)requestMsgData {
	NSDictionary *param = @{
							@"token": [User sharedUser].token,
							@"userId": [User sharedUser].userId,
							};
	[[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/orderInfoCustomer/%@", [User sharedUser].userId] withParameters:param success:^(id ret) {
		self.dataSource = ret[@""];
		[_msgTableView reloadData];
		self.emptyDataView.hidden = self.dataSource.count;
	} error:^(NSString *code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
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
