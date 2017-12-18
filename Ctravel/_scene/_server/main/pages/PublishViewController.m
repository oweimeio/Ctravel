//
//  PublishViewController.m
//  Ctravel
//
//  Created by 华奥 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PublishViewController.h"
#import "PreHeader.h"

@interface PublishViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@property (weak, nonatomic) IBOutlet UIButton *preViewBtn;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self setDefaultTheme];
	
	Experience *ex = [Experience defaultExperience];
	Experience *exMem = [Experience getExperienceDataWithUID:[User sharedUser].userId];

    [self.photoView setImageWithURLString:!exMem.imageUrl_main?ex.imageUrl_main:exMem.imageUrl_main andPlaceholderNamed:@"placeholder-none"];
    self.desLabel.text = [NSString stringWithFormat:@"￥%.0f\n·%@\n·%@-%@",ex.price, !exMem.title ?ex.title : exMem.title,!ex.defaultTimeStart?exMem.defaultTimeStart:ex.defaultTimeStart,!ex.defaultTimeEnd?exMem.defaultTimeEnd:ex.defaultTimeEnd];
    
    if ([User sharedUser].getUserData.isPublished) {
        _publishBtn.hidden = YES;
        _progressView.hidden = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"注销" style:UIBarButtonItemStylePlain handler:^(id sender) {
            User *user = [User sharedUser];
            user.isPublished = NO;
            [user saveUserData];
            [[AppDelegate app] switchAppType:AppTypePolice];
        }];
    }
}

//预览
- (IBAction)preViewBtnClick:(id)sender {
    Experience *experience = ![Experience getExperienceDataWithUID:[User sharedUser].userId] ? [Experience defaultExperience] : [Experience getExperienceDataWithUID:[User sharedUser].userId];
    PreViewViewController *preViewVc = [PreViewViewController new];
    preViewVc.dataSource = [self loadExperienceForDict:experience];
    [self.navigationController pushViewController:preViewVc animated:YES];
}

//发布
- (IBAction)publishBtnClick:(id)sender {
	
    Experience *exVc = [Experience getExperienceDataWithUID:[User sharedUser].userId];
    NSLog(@"%@",exVc);
    NSDictionary *params = @{
                             @"token":[User sharedUser].token,
                             @"customerId":[User sharedUser].userId,
                             @"title":![Experience defaultExperience].title?exVc.title:[Experience defaultExperience].title,
                             @"styleId":![Experience defaultExperience].styleId?exVc.styleId:[Experience defaultExperience].styleId,
                             @"serviceName":![Experience defaultExperience].style? exVc.style:[Experience defaultExperience].style,
							 @"city":![Experience defaultExperience].city?exVc.city:[Experience defaultExperience].city,
                             @"contentDescription":![Experience defaultExperience].contentDes?@"":[Experience defaultExperience].contentDes,
                             @"destination":![Experience defaultExperience].destination?@"":[Experience defaultExperience].destination,
                             @"rendezvous":![Experience defaultExperience].rendezvous?@"":[Experience defaultExperience].rendezvous,
                             @"mustKnow":![Experience defaultExperience].mustKnow?@"":[Experience defaultExperience].mustKnow,
                             @"comment":![Experience defaultExperience].mark?@"":[Experience defaultExperience].mark,
                             @"requirement":![Experience defaultExperience].requirement?@"":[Experience defaultExperience].requirement,
							 @"peopleNumber": ![Experience defaultExperience].peopleCount ? exVc.peopleCount == 0 ? @(5) : @(exVc.peopleCount):@([Experience defaultExperience].peopleCount),
                             @"defaultStartTime":![Experience defaultExperience].defaultTimeStart ? exVc.defaultTimeStart : [Experience defaultExperience].defaultTimeStart ,
                             @"defaultEndTime":![Experience defaultExperience].defaultTimeEnd ?exVc.defaultTimeEnd :[Experience defaultExperience].defaultTimeEnd,
                             @"currencyType":![Experience defaultExperience].currencyType ? @"RMB" : [Experience defaultExperience].currencyType,
                             @"price":@([Experience defaultExperience].price),
                             @"imageUrl":[NSString stringWithFormat:@"%@,%@,%@",![Experience defaultExperience].imageUrl_main? @"" : [Experience defaultExperience].imageUrl_main,![Experience defaultExperience].imageUrl_left? @"" : [Experience defaultExperience].imageUrl_left,![Experience defaultExperience].imageUrl_right? @"" : [Experience defaultExperience].imageUrl_right]
                             };
    [[CoreAPI core] POSTURLString:@"/experience/experiences" withParameters:params success:^(id ret) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功,请设置您的体验日期"];
        User *user = [User sharedUser];
        user.isPublished = YES;
        [user saveUserData];
        [[AppDelegate app] switchAppType:AppTypePolice];
    } error:^(NSString *code, NSString *msg, id ret) {
        [SVProgressHUD showErrorWithStatus:msg];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
    }];
    
}

- (void)setDefaultTheme {
	self.preViewBtn.layer.borderWidth = 2;
	self.preViewBtn.layer.borderColor = [[UIColor colorWithHex:@"1890B5" andAlpha:1] CGColor];
	self.preViewBtn.layer.cornerRadius = 5;
	self.preViewBtn.layer.masksToBounds = YES;
	self.publishBtn.layer.cornerRadius = 5;
	self.publishBtn.layer.masksToBounds = YES;
}

#pragma mark -隐藏TabBar
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark -显示TabBar
- (void)showTabBar {
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSDictionary*)loadExperienceForDict:(Experience*)obj {
    
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    if (obj.imageUrl_main) {
        resultDict[@"imageUrl"] = obj.imageUrl_main;
    }
    if (obj.contentDes) {
        resultDict[@"contentDetails"] = obj.contentDes;
    }
    if (obj.style) {
        resultDict[@"serviceName"] = obj.style;
    }
    if ([User sharedUser].familyName) {
        resultDict[@"familyName"] = [User sharedUser].familyName;
    }
    if ([User sharedUser].firstName) {
        resultDict[@"firstName"] = [User sharedUser].firstName;
    }
    if ([User sharedUser].avatarUrl) {
        resultDict[@"headImg"] = [User sharedUser].avatarUrl;
    }
    if (obj.destination) {
        resultDict[@"destination"] = obj.destination;
    }
    if (obj.rendezvous) {
        resultDict[@"rendezvous"] = obj.rendezvous;
    }
    if (obj.mark) {
        resultDict[@"comment"] = obj.mark;
    }
    if (obj.requirement) {
        resultDict[@"requirement"] = obj.requirement;
    }
    if (obj.peopleCount) {
        resultDict[@"peopleNumber"] = [NSString stringWithFormat:@"%ld",obj.peopleCount];
    }
    if (obj.price) {
        resultDict[@"price"] = [NSString stringWithFormat:@"%.0f",obj.price];
    }
    return resultDict;
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
