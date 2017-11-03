//
//  DateViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DateViewController.h"
#import "PreHeader.h"

@interface DateViewController ()<JTCalendarDelegate> {
    NSMutableDictionary *_eventsByDate;
    
    NSMutableArray *_datesSelected;
    
    BOOL _selectionMode;
}

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _datesSelected = [NSMutableArray new];
    _selectionMode = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_hideNavBar) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_hideNavBar) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (IBAction)saveBtnClick:(id)sender {
    if (_datesSelected.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择日期"];
        return;
    }
    NSString *dateStr = @"";
    for (NSDate *date in _datesSelected) {
        dateStr = [NSString stringWithFormat:@"%@,%@", dateStr,[date stringWithFormat:@"yyyy-MM-dd"]];
    }
    //去除第一个逗号
    dateStr = [dateStr substringFromIndex:1];
    NSLog(@"%@", dateStr);
}

- (void)clearUpAllDate {
    if(_selectionMode){
        [_datesSelected removeAllObjects];
        [_calendarManager reload];
    }
}

- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

- (void)selectDates
{
    NSDate * startDate = [_datesSelected firstObject];
    NSDate * endDate = [_datesSelected lastObject];
    
    if([_calendarManager.dateHelper date:startDate isEqualOrAfter:endDate]){
        NSDate *nextDate = endDate;
        while ([nextDate compare:startDate] == NSOrderedAscending) {
            [_datesSelected addObject:nextDate];
            nextDate = [_calendarManager.dateHelper addToDate:nextDate days:1];
        }
    }
    else {
        NSDate *nextDate = startDate;
        while ([nextDate compare:endDate] == NSOrderedAscending) {
            [_datesSelected addObject:nextDate];
            nextDate = [_calendarManager.dateHelper addToDate:nextDate days:1];
        }
    }
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return dateFormatter;
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if(_selectionMode && _datesSelected.count == 1 && ![_calendarManager.dateHelper date:[_datesSelected firstObject] isTheSameDayThan:dayView.date]){
        [_datesSelected addObject:dayView.date];
        [self selectDates];
        _selectionMode = NO;
        [_calendarManager reload];
        return;
    }
    
    
    if([self isInDatesSelected:dayView.date]){
        [_datesSelected removeObject:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:nil];
    }
    else{
        [_datesSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    }
    
    if(_selectionMode) {
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
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
