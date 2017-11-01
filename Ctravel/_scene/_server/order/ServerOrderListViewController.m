//
//  ServerOrderListViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ServerOrderListViewController.h"
#import "PreHeader.h"
#import "ServerOrderHistoryListViewController.h"

@interface ServerOrderListViewController ()

@end

@implementation ServerOrderListViewController

- (instancetype)init {
	if (self = [super initWithNibName:@"ServerOrderListViewController" bundle:[NSBundle mainBundle]]) {
		self.hidesBottomBarWhenPushed = YES;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	[self setupTitle];
}

- (void)setupTitle {
	
	SLSegmentPageView *page = [[SLSegmentPageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
	[page slPageTitleArr:^NSArray *{
		return @[@"已完成",@"未来"];
	} contentController:^UIViewController *(NSInteger item) {
		ServerOrderHistoryListViewController *list = [[ServerOrderHistoryListViewController alloc] init];
		if (item == 0) {
			list.type = OrderTypeCompleted;
		}else{
			list.type = OrderTypeFuture;
		}
		return list;
	}];
	[self.view addSubview:page];
	
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
