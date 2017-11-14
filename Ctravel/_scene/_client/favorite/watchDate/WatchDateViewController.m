//
//  WatchDateViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WatchDateViewController.h"
#import "PreHeader.h"
#import "WatchDateCell.h"

@interface WatchDateViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;

@end

@implementation WatchDateViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WatchDateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:WatchDateCellIdentifier];
    
    self.tableView.tableFooterView = [UIView new];
	
	[self requestDateData];
}

- (void)requestDateData {
	NSDictionary *param = @{
							@"token":[User sharedUser].token,
							@"customerId":[User sharedUser].userId,
							@"experienceId":self.expId
							};
	[[CoreAPI core] GETURLString:@"/experience/serviceTime" withParameters:param success:^(id ret) {
		self.dataSource = ret[@"serviceTimeVOList"];
		self.emptyDataView.hidden = self.dataSource.count;
		[_tableView reloadData];
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
	}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WatchDateCell *cell = [tableView dequeueReusableCellWithIdentifier:WatchDateCellIdentifier forIndexPath:indexPath];
	__weak NSDictionary *dic = self.dataSource[indexPath.row];
	cell.timeLabel.text = dic[@"serviceDate"];
	[cell.reserveBtn bk_addEventHandler:^(id sender) {
		
//		NSDictionary *param = @{
//								@"token":[User sharedUser].token,
//								@"customerId":[User sharedUser].userId,
//								@"dateTimeString":dic[@"serviceDate"]
//								};
//		[[CoreAPI core] POSTURLString:@"" withParameters:param success:^(id ret) {
//			[SVProgressHUD showSuccessWithStatus:@"预定成功"];
//		} error:^(NSString *code, NSString *msg, id ret) {
//			[SVProgressHUD showErrorWithStatus:msg];
//		} failure:^(NSError *error) {
//			[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
//		}];
	} forControlEvents:UIControlEventTouchUpInside];
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
