//
//  ClientOrderListViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientOrderListViewController.h"
#import "PreHeader.h"
#import "ClientCompleteViewController.h"

@interface ClientOrderListViewController ()

@end

@implementation ClientOrderListViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"ClientOrderListViewController" bundle:[NSBundle mainBundle]]) {
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
        ClientCompleteViewController *list = [[ClientCompleteViewController alloc] init];
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
