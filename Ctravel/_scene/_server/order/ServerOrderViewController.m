//
//  ServerOrderViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerOrderViewController.h"
#import "ServerOrderCell.h"
#import "PreHeader.h"
#import "ServerOrderListViewController.h"

@interface ServerOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ServerOrderViewController

- (NSArray *)dataSource {
	if (!_dataSource) {
		_dataSource = @[];
	}
	return _dataSource;
}

- (instancetype)init {
	if (self = [super initWithNibName:@"ServerOrderViewController" bundle:[NSBundle mainBundle]]) {
		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self.tableView registerNib:[UINib nibWithNibName:@"ServerOrderCell" bundle:[NSBundle mainBundle
																				 ]] forCellReuseIdentifier:ServerOrderCellIdentifier];
	
	self.tableView.tableFooterView = [UIView new];
	
	[self requestOrderListData];
}

//MARK: - ACTION
- (IBAction)watchDealRecordsBtnClick:(id)sender {
	[self.navigationController pushViewController:[ServerOrderListViewController new] animated:YES];
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
