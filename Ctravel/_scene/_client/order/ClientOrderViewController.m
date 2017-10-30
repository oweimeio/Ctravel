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
    
    [self requestOrderListData];
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
                            @"userId": [User sharedUser].userId,
                            };
    [[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/orderInfoCustomer/%@", [User sharedUser].userId] withParameters:param success:^(id ret) {
        self.dataSource = ret[@""];
        [_tableView reloadData];
        self.emptyDataView.hidden = self.dataSource.count;
    } error:^(NSString *code, NSString *msg, id ret) {
        
    } failure:^(NSError *error) {
        
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
