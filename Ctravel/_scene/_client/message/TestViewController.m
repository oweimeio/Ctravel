//
//  TestViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
