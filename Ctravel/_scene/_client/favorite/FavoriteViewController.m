//
//  FavoriteViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FavoriteViewController.h"
#import "PreHeader.h"
#import "HotExperienceCell.h"

@interface FavoriteViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *favCollectionView;

@property (weak, nonatomic) IBOutlet EmptyDataView *emptyView;

@end

@implementation FavoriteViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[];
    }
    return _dataSource;
}

- (instancetype)init {
    if (self = [super initWithNibName:@"FavoriteViewController" bundle:[NSBundle mainBundle]]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_hideNavBar) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_hideNavBar) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.favCollectionView registerNib:[UINib nibWithNibName:@"HotExperienceCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:hotExperienceCellInIdentifier];
    
    if (_keywords) {
        _titleLabel.text = _keywords;
    }
    if (_titleStr) {
        _titleLabel.text = _titleStr;
    }
	self.favCollectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
		[self requestListData:NO];
	}];
	
	self.favCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		[self requestListData:YES];
	}];
	
	[self.favCollectionView.mj_header beginRefreshing];

}

//MARK: - METHOD
- (void)requestListData:(BOOL)paging {
	NSInteger pageSize = 10;
    //查询的时候通过keyword 查询
    NSDictionary *param = @{
                            @"token":[User sharedUser].token,
                            @"customerId":[User sharedUser].userId,
                            @"title":!self.keywords?@"":self.keywords,
							@"page":paging ? @(self.dataSource.count / pageSize + 1) : @1,
                            @"rows":@(pageSize)
                            };
    [[CoreAPI core] GETURLString:@"/experience/conditionQuery" withParameters:param success:^(id ret) {
        NSLog(@"%@",ret);
        self.dataSource = ret[@"experienceDetail"];
        [_favCollectionView reloadData];
        _emptyView.hidden = self.dataSource.count;
		[self.favCollectionView.mj_header endRefreshing];
		[self.favCollectionView.mj_footer endRefreshing];
    } error:^(NSString *code, NSString *msg, id ret) {
        [SVProgressHUD showErrorWithStatus:msg];
		[self.favCollectionView.mj_header endRefreshing];
		[self.favCollectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:HA_ERROR_NETWORKING_INVALID];
		[self.favCollectionView.mj_header endRefreshing];
		[self.favCollectionView.mj_footer endRefreshing];
    }];
}

//MARK:COLLECTIONDEGATE &DATASOURCE
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotExperienceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotExperienceCellInIdentifier forIndexPath:indexPath];
    __weak NSDictionary *dataSource = self.dataSource[indexPath.row];
    cell.dataSource = dataSource;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FavDetailViewController *favDetailVc = [FavDetailViewController new];
    favDetailVc.dataSource = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:favDetailVc animated:YES];
}

//MARK: - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return (CGSize){(WIDTH - 30) * 0.5, (WIDTH - 30) * 0.5 *284/168};
   
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
