//
//  HAPageViewController.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-01-19.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAPageViewController.h"
#import <WebKit/WebKit.h>
#import "HACoreHeader.h"
#import "LYCategory.h"

@interface HAPageViewController () <WKNavigationDelegate, WKUIDelegate> {
	
	__weak WKWebView *webview;
	
	NSString *hmTitle;
	NSString *hmURLString;
	NSString *hmContent;
}

@end

@implementation HAPageViewController

// MARK: - ACTION

// MARK: - INIT

- (instancetype)init {
	if (self = [super init]) {
		
		hmTitle = hmURLString = hmContent = @"";
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)title andURLString:(NSString *)URLString orContent:(NSString *)contentString {
	if (self = [super init]) {
		
		hmTitle = title != nil ? title : @"";
		hmURLString = URLString != nil ? URLString : @"";
		hmContent = contentString != nil ? contentString : @"";
		
	}
	return self;
}

// MARK: | VIEW LIFE CYCLE

- (void)loadView {
	[super loadView];
	
	{
		WKWebViewConfiguration *wbconf = [[WKWebViewConfiguration alloc] init];
		
		/*
		wbconf.preferences = [[WKPreferences alloc] init];
		wbconf.preferences.javaScriptEnabled = YES;
		wbconf.preferences.minimumFontSize = 10;
		*/
		
		WKWebView *web = [[WKWebView alloc] initWithFrame:(CGRect){0, 0, WIDTH, HEIGHT} configuration:wbconf];
		web.UIDelegate = self;
		[self.view addSubview:web];
		
		webview = web;
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
	
	self.navTitle = hmTitle;
	
	if (![hmURLString isEmpty]) {
		[webview loadRequest:[NSURLRequest requestWithFormat:@"%@", hmURLString]];
	} else {
		if (![hmContent isEmpty]) {
			[webview loadHTMLString:hmContent baseURL:nil];
		} else {
			[[HACore core] logInnerError:@"Page View with nil URL and Content."];
		}
	}
	
}

// MARK: | MEMORY MANAGEMENT

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: | PRIVATE METHOD

// MARK: - DELEGATE

// MARK: | WKNavigationDelegate

// MARK: | WKUIDelegate

// MARK: - NOTIFICATION

@end
