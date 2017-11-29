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
#import "BuyProViewController.h"

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
                            @"customerStarId":self.serverId,
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

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil ];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)string{
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WatchDateCell *cell = [tableView dequeueReusableCellWithIdentifier:WatchDateCellIdentifier forIndexPath:indexPath];
	__weak NSDictionary *dic = self.dataSource[indexPath.row];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@·%@·%@-%@", dic[@"serviceDate"],[self weekdayStringFromDate:[self dateFromString:dic[@"serviceDate"]]], _startTime, _endTime];
	[cell.reserveBtn bk_addEventHandler:^(id sender) {
//        if ([_delegate respondsToSelector:@selector(chooseDate:andDateId:)]) {
//            [_delegate chooseDate:dic[@"serviceDate"] andDateId:dic[@"serviceTimeId"]];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
        NSDictionary *param = @{
                                @"experienceId":_detailData[@"experienceId"],
                                @"userId":[User sharedUser].userId,
                                @"token":[User sharedUser].token,
                                @"serviceTimeId":dic[@"serviceTimeId"]
                                };
        [[CoreAPI core] GETURLString:[NSString stringWithFormat:@"/pay/reserve/%@",_detailData[@"experienceId"]] withParameters:param success:^(id ret) {
            NSLog(@"%@",ret);
            BuyProViewController *buyVc = [[BuyProViewController alloc] init];
            buyVc.dataSource = _detailData;
            buyVc.orderId = ret[@"orderInfo"][@"orderId"];
            buyVc.date = dic[@"serviceDate"];
            [self.navigationController pushViewController:buyVc animated:YES];
            
        } error:^(NSString *code, NSString *msg, id ret) {
            
        } failure:^(NSError *error) {
            
        }];
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
