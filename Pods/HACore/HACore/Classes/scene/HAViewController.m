//
//  HAViewController.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-28.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAViewController.h"

@interface HAViewController ()

@end

@implementation HAViewController

// MARK: - VIEW LIFE CYCLE

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (_navTitle != nil && self.navigationController != nil) {
		// IF IT'S NAV CONTROLLER
		// SET TITLE BACK
		[self.navigationItem setTitle:_navTitle];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	if (self.navigationController != nil) {
		// SET EMPTY TITLE
		[self.navigationItem setTitle:@""];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: | PRIVATE

// MARK: - PROPERTY

- (void)setNavTitle:(NSString *)navTitle {
	_navTitle = navTitle;
	
	if (self.navigationController != nil) {
		self.navigationItem.title = navTitle;
	}
}

// MARK: - DELEGATE

// MARK: - NOTIFICATION

@end
