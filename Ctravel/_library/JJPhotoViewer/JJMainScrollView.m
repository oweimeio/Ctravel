//
//  JJMainScrollView.m
//  test
//
//  Created by KimBox on 15/4/28.
//  Copyright (c) 2015年 KimBox. All rights reserved.
//

#import "JJMainScrollView.h"
#import "JJPhoto.h"
#import "JJOneScrollView.h"

#define Gap 10   //俩照片间黑色间距
#define MianW [UIScreen mainScreen].bounds.size.width
#define MianH [UIScreen mainScreen].bounds.size.height
#define RGBColor(r , g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0 ]
#define RandomColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface JJMainScrollView()<UIScrollViewDelegate,JJOneScrollViewDelegate>
//存放了所有 单个滚动器
@property(nonatomic,strong)NSMutableArray *oneScrolArr;

@property(nonatomic,assign)NSInteger willBeginDraggingIndex;

@end

@implementation JJMainScrollView

//存放了所有 单个滚动器数组懒加载
-(NSMutableArray *)oneScrolArr
{
	if(_oneScrolArr == nil)
	{
		_oneScrolArr = [NSMutableArray array];
	}
	return  _oneScrolArr;
}

#pragma mark - 自己的属性设置一下
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		//设置主滚动创的大小位置
		self.frame = CGRectMake(-Gap, 0, [UIScreen mainScreen].bounds.size.width + Gap + Gap,[UIScreen mainScreen].bounds.size.height);
		//分页
		self.pagingEnabled = YES;
		self.showsHorizontalScrollIndicator = NO;
		//代理
		self.delegate = self;
	}
	return self;
}

#pragma mark - 拿到数据时展示
-(void)setPhotoData:(NSArray *)photoArr Type:(JJPhotoViewerType)type
{
	
	//设置可滚动范围
	self.contentSize =  CGSizeMake(photoArr.count * self.frame.size.width, 0);
	
	//点击进来的ImageView是数组中的第几个?
	NSInteger selcImageIndex = 0;
	for(int i = 0 ; i < photoArr.count ; i++)
	{
		JJPhoto *photo = photoArr[i];
		if(photo.isSelecImageView == YES)
		{
			selcImageIndex = i;
			break;
		}
	}
	
	//设置首个展示页面
	self.contentOffset = CGPointMake(selcImageIndex * self.frame.size.width, 0);
	//设置一个相片
	for (int i = 0; i < photoArr.count ; i ++)
	{
		//取出照片模型
		JJPhoto *photo =  photoArr[i];
		//传值给单个滚动器
		JJOneScrollView *oneScroll = [[JJOneScrollView alloc]init];
		oneScroll.mydelegate = self;
		//自己是数组中第几个图
		oneScroll.myindex = i;
		//设置位置并添加
		oneScroll.frame = CGRectMake((i*self.frame.size.width)+Gap , 0 ,MianW, MianH);
		[self addSubview:oneScroll];
		//加载图片方式
		switch (type) {
				//本地加载图图
			case JJLocalWithLocalPhotoViewer:
				[oneScroll setLocalImage:photo.imageView  ];
				break;
				//网络加载图图
			case JJInternetWithInternetPhotoViewer:
				[oneScroll setNetWorkImage:photo.imageView urlStr:photo.urlStr ];
				break;
		}
		//添加到单个滚动创集合
		[self.oneScrolArr addObject:oneScroll];
	}
}

#pragma mark - 滚动监听 重置缩放
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	NSInteger x = scrollView.contentOffset.x;
	NSInteger w = scrollView.bounds.size.width;
	NSInteger gapHead = (x % w);
	NSInteger mainW =   self.frame.size.width ;
	NSInteger gapEnd =  mainW - gapHead;
	
	//接近30个点 边距的时候会调用 用0的话有的时候不触发
	if(labs(gapHead) <= 20.0 ||labs(gapEnd) <= 20.0  )
	{
		//当前观看的这个是第几个oneSc
		NSInteger  nowLookIndex =( scrollView.contentOffset.x + (scrollView.bounds.size.width/2)) /scrollView.bounds.size.width  ;
		for(int i = 0;i < self.oneScrolArr.count ; i++  )
		{
			if (i != nowLookIndex) {//除了当前看的 其他都给我重置位置
				JJOneScrollView *one = self.oneScrolArr[i];
				[one reloadFrame];
			}else
			{
				
			}
		}
	}
}

#pragma mark - OneScroll的代理方法
//即将退出图片浏览器
-(void)willGoBack:(NSInteger)seletedIndex {
	//防崩
	self.delegate = nil;
	//返回退出时点的ImageView的序号给代理
    if ([self.delegate respondsToSelector:@selector(photoViwerWilldealloc:)]) {
        [self.mainDelegate photoViwerWilldealloc:seletedIndex];
    }
}

//退出图片浏览器
-(void)goBack
{
	//让原始底层UIView死掉
	[self.superview removeFromSuperview];
}

#pragma mark - 释放代理防崩
-(void)dealloc
{
	self.delegate = nil;
}

@end
