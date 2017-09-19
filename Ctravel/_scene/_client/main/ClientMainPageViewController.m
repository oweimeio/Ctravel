//
//  ClientMainPageViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientMainPageViewController.h"

@interface ClientMainPageViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *hotDestinationView;
@property (strong, nonatomic) NSArray *hotDestinationData;

@property (weak, nonatomic) IBOutlet UICollectionView *hotExperience;
@property (strong, nonatomic) NSArray *hotExperienceData;

@end

@implementation ClientMainPageViewController

- (NSArray *)hotDestinationData {
	if (!_hotDestinationData) {
		_hotDestinationData = @[
							@{@"title":@"罗马", @"imgUrl":@""},
							@{@"title":@"罗马", @"imgUrl":@""},
							@{@"title":@"罗马", @"imgUrl":@""},
							@{@"title":@"罗马", @"imgUrl":@""},];
		
		[_hotDestinationView reloadData];
	}
	return _hotDestinationData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
