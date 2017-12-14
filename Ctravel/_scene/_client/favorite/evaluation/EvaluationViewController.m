//
//  EvaluationViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EvaluationViewController.h"
#import "PreHeader.h"
#import "EvaluationCell.h"

@interface EvaluationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;
@end

@implementation EvaluationViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EvaluationCell" bundle:[NSBundle mainBundle
                                                                  ]] forCellReuseIdentifier:EvaluationCellIdentifier];
    
    self.tableView.tableFooterView = [UIView new];
	
	self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
		[self requestCommont:NO];
	}];
	
	self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		[self requestCommont:YES];
	}];
	
	[self.tableView.mj_header beginRefreshing];
}

- (void)requestCommont:(BOOL)paging {
	NSInteger pageSize = 10;
	NSDictionary *param = @{
							@"token":[User sharedUser].token,
							@"customerId":[User sharedUser].userId,
							@"page":paging ? @(self.dataSource.count / pageSize + 1) : @1,
							@"rows":@(pageSize),
							@"experienceId":!self.expId ? @"": self.expId
							};
	[[CoreAPI core] GETURLString:@"/comment/conditionQuery" withParameters:param success:^(id ret) {
		NSLog(@"%@",ret);
		self.dataSource = ret[@"experienceDetail"];
		[_tableView reloadData];
		_emptyDataView.hidden = self.dataSource.count;
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
	} error:^(NSString *code, NSString *msg, id ret) {
		[SVProgressHUD showErrorWithStatus:msg];
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
	} failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
	}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:EvaluationCellIdentifier forIndexPath:indexPath];
	__weak NSDictionary *dic = self.dataSource[indexPath.row];
    [cell.avatarImageView setImageWithURLString:dic[@""] andPlaceholderNamed:@"defaultHeadImage"];
    cell.nameLabel.text = dic[@""];
	cell.dateTime.text = [[NSDate dateWithTimeIntervalSince1970:[dic[@"createTime"] doubleValue]/1000] stringWithFormat:@"yyyy-MM-dd" andTimezone:SHANGHAI];;
	cell.contentLabel.text = [NSString stringWithFormat:@"评论内容：%@",dic[@"commentContent"]];
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
