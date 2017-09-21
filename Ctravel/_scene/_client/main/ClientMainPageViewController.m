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

@property (weak, nonatomic) IBOutlet UICollectionView *hotExperienceView;
@property (strong, nonatomic) NSArray *hotExperienceData;

@end

@implementation ClientMainPageViewController

- (NSArray *)hotDestinationData {
	if (!_hotDestinationData) {
		_hotDestinationData = @[
							@{@"title":@"罗马", @"imgUrl":@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"},
							@{@"title":@"罗马", @"imgUrl":@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyiCIYAW0AA6U_PRWkBcAALIXAL8oScADpUU566.jpg"},
							@{@"title":@"罗马", @"imgUrl":@""},
							@{@"title":@"罗马", @"imgUrl":@""},];
		
		[_hotDestinationView reloadData];
	}
	return _hotDestinationData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"热门";
}

//MARK:COLLECTIONDEGATE &DATASOURCE
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _hotDestinationView) {
        return self.hotDestinationData.count;
    }
    else if (collectionView == _hotExperienceView) {
        return self.hotExperienceData.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
