//
//  ClientMsgViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientMsgViewController.h"
#import "ClientMsgCell.h"

@interface ClientMsgViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *msgTableView;

@end

@implementation ClientMsgViewController

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
    self.navigationItem.title = @"消息";
    
    self.msgTableView.tableFooterView = [UIView new];
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
