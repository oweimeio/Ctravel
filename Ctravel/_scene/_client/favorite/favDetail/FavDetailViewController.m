//
//  FavDetailViewController.m
//  Ctravel
//
//  Created by apple on 2017/9/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FavDetailViewController.h"
#import "PreHeader.h"
#import "EvaluationViewController.h"
#import "WatchDateViewController.h"

@interface FavDetailViewController ()

@property (nonatomic)CGSize headerDefaultSize;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picConstant;

@end

@implementation FavDetailViewController

- (instancetype)init {
    if (self = [super initWithNibName:@"FavDetailViewController" bundle:[NSBundle mainBundle]]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [self.picImageView setImageWithURLString:@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg" andPlaceholderNamed:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDataSource:_dataSource];
    
    self.headerDefaultSize = self.picImageView.frame.size;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}

//MARK: - ACTION

- (IBAction)navBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)watchExMasterDate:(id)sender {
    WatchDateViewController *watchVc = [WatchDateViewController new];
    [self.navigationController pushViewController:watchVc animated:YES];
}

- (IBAction)watchEvaluation:(id)sender {
    EvaluationViewController *evaVc = [EvaluationViewController new];
    [self.navigationController pushViewController:evaVc animated:YES];
}

- (IBAction)connectMaster:(id)sender {
}

- (IBAction)reserveBtnClick:(id)sender {
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.bounces = (scrollView.contentOffset.y <= 100) ? NO : YES;
//    CGFloat diff = -self.scrollView.contentOffset.y;
//    
//    if (self.scrollView.contentOffset.y < 0) {
//        CGFloat oldH = self.headerDefaultSize.height;
//        CGFloat oldW = self.headerDefaultSize.width;
//        
//        CGFloat newH = oldH + diff;
//        CGFloat newW = oldW *newH/oldH;
//        
//        self.picImageView.frame  = CGRectMake(0, 0, newW, newH);
//        self.picImageView.center = CGPointMake(oldW/2.0f, (oldH-diff)/2.0f);
//        
//    }
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
