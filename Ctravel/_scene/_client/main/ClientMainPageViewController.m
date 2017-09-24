//
//  ClientMainPageViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClientMainPageViewController.h"
#import "HotExperienceCell.h"
#import "HotDestinationCell.h"
#import "PreHeader.h"

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
							@{@"title":@"罗马", @"imgUrl":@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"}];
		
		[_hotDestinationView reloadData];
	}
	return _hotDestinationData;
}

- (NSArray *)hotExperienceData {
    if (!_hotExperienceData) {
        _hotExperienceData = @[
                                @{@"title":@"罗马", @"imgUrl":@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"},
                                @{@"title":@"罗马", @"imgUrl":@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyiCIYAW0AA6U_PRWkBcAALIXAL8oScADpUU566.jpg"},
                                @{@"title":@"罗马", @"imgUrl":@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg"}];
        
        [_hotDestinationView reloadData];
    }
    return _hotExperienceData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationItem.title = @"热门";
    [self.navigationController.view addSubview:[UISearchBar new]];
    
    [self.hotDestinationView registerNib:[UINib nibWithNibName:@"HotDestinationCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:hotDestinationCellInIdentifier];
    
    [self.hotExperienceView registerNib:[UINib nibWithNibName:@"HotExperienceCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:hotExperienceCellInIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSDictionary *params = @{
//                             @"token":[HAApp current].atoken
//                             };
//    [[CoreAPI core] GETURLString:@"/hot/hotDestinationExperience" withParameters:params success:^(id ret) {
//        
//    } error:^(NSString *code, NSString *msg, id ret) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
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
    if (collectionView == _hotDestinationView) {
        HotDestinationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotDestinationCellInIdentifier forIndexPath:indexPath];
        cell.dataSource = self.hotDestinationData[indexPath.row];
        return cell;
    }
    else if (collectionView == _hotExperienceView) {
        HotExperienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotExperienceCellInIdentifier forIndexPath:indexPath];
        __weak NSDictionary *dataSource = self.hotExperienceData[indexPath.row];
        cell.dataSource = dataSource;
//        [cell.picImageView setImageWithURLString:dataSource[@"imageUrl"] andPlaceholderNamed:@""];
//        cell.nameLabel.text = dataSource[@"title"];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _hotDestinationView) {
        return (CGSize){110, 100};
    }
    else if (collectionView == _hotExperienceView) {
        return (CGSize){(WIDTH - 40) * 0.5, (WIDTH - 40) * 0.5 *284/168};
    }
    return (CGSize){0, 0};
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
