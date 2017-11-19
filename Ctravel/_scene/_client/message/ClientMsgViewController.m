//
//  ClientMsgViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientMsgViewController.h"
#import "ClientMsgCell.h"
#import "PreHeader.h"

@interface ClientMsgViewController () <RCIMUserInfoDataSource>

@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *msgTableView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyDataView;
@end

@implementation ClientMsgViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.msgTableView.tableFooterView = [UIView new];
//    
//    self.msgTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        [self requestMsgData:NO];
//    }];
//    
//    self.msgTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [self requestMsgData:YES];
//    }];
//    
//    [self.msgTableView.mj_header beginRefreshing];
	[[RCIM sharedRCIM] setUserInfoDataSource:self];
	
	//设置需要显示哪些类型的会话
	[self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
										@(ConversationType_DISCUSSION),
										@(ConversationType_CHATROOM),
										@(ConversationType_GROUP),
										@(ConversationType_APPSERVICE),
										@(ConversationType_SYSTEM)]];
	//设置需要将哪些类型的会话在会话列表中聚合显示
	[self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
										  @(ConversationType_GROUP)]];
	UIView *headerView = [[UIView alloc] init];
	headerView.frame = CGRectMake(0, 0, WIDTH, 50);
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 32)];
	titleLabel.text = @"消息";
	titleLabel.font = [UIFont systemFontOfSize:26 weight:1];
	titleLabel.textColor = [UIColor blackColor];
	[headerView addSubview:titleLabel];
	self.conversationListTableView.tableHeaderView = headerView;
	self.conversationListTableView.tableFooterView = [UIView new];
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

	/**
	 *重写RCConversationListViewController的onSelectedTableRow事件
	 *
	 *  @param conversationModelType 数据模型类型
	 *  @param model                 数据模型
	 *  @param indexPath             索引
	 */
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
	RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
	conversationVC.conversationType =model.conversationType;
	conversationVC.targetId = model.targetId;
	conversationVC.title = model.conversationTitle;
	conversationVC.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:conversationVC animated:YES];
}
	
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion {
	//自己
	if ([[User sharedUser].userId isEqual:userId]) {
		RCUserInfo *user = [[RCUserInfo alloc]init];
		user.userId = [User sharedUser].userId;
		user.name = [NSString stringWithFormat:@"%@%@",[User sharedUser].familyName,[User sharedUser].firstName];
		user.portraitUri = [User sharedUser].avatarUrl;
		return completion(user);
	}
	//别人
	else {
		NSDictionary *param = @{
								@"token":[User sharedUser].token,
								@"customerId":userId
								};
		[[CoreAPI core] GETURLString:@"/customer" withParameters:param success:^(id ret) {
			NSDictionary *dic = ret[@"customerDetail"];
			RCUserInfo *user = [[RCUserInfo alloc]init];
			user.userId = dic[@"customerId"];
			user.name = [NSString stringWithFormat:@"%@%@",dic[@"familyName"],dic[@"firstName"]];
			user.portraitUri = dic[@"idcardImg"];
			return completion(user);
		} error:^(NSString *code, NSString *msg, id ret) {
			
		} failure:^(NSError *error) {
			
		}];
	}
}




	
//MARK: - TABLEDELEGATE & DATASOURCE
	
	
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ClientMsgCell *cell = [ClientMsgCell clientMsgCellInTableView:tableView];
//    cell.dataSource = self.dataSource[indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    //让未读的信息变已读
//}

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
