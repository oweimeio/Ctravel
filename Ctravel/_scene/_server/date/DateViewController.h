//
//  DateViewController.h
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

@interface DateViewController : UIViewController

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (assign, nonatomic) BOOL hideNavBar;

@end
