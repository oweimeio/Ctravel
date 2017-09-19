//
//  EmptyDataView.m
//  WJW2
//
//  CREATED BY LUO YU ON 2016-08-15.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import "EmptyDataView.h"
#import <Masonry/Masonry.h>

@implementation EmptyDataView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self initialNib];
	}
	return self;
}

- (void)initial {
	UILabel *labelText = [UILabel new];
	labelText.text = @"暂无数据";
	labelText.textColor = [UIColor colorWithWhite:0.745 alpha:1];
	labelText.font = [UIFont systemFontOfSize:15];
	labelText.textAlignment = NSTextAlignmentCenter;
	[labelText sizeToFit];
	[self addSubview:labelText];
	_lblHint = labelText;
	
	UIImageView *imageIcon = [UIImageView new];
	imageIcon.image = [UIImage imageNamed:@"placeholder-empty-data"];
	[imageIcon sizeToFit];
	[self addSubview:imageIcon];
	_ivIcon = imageIcon;
	
	self.userInteractionEnabled = _lblHint.userInteractionEnabled = _ivIcon.userInteractionEnabled = NO;
	self.backgroundColor = _lblHint.backgroundColor = _ivIcon.backgroundColor = [UIColor clearColor];
	self.hidden = YES;
	
	[self setFrame:CGRectZero];

}

- (void)initialNib {
	UILabel *labelText = [UILabel new];
	labelText.text = @"暂无数据";
	labelText.textColor = [UIColor colorWithWhite:0.745 alpha:1];
	labelText.font = [UIFont systemFontOfSize:15];
	labelText.textAlignment = NSTextAlignmentCenter;
	[labelText sizeToFit];
	[self addSubview:labelText];
	_lblHint = labelText;
	
	UIImageView *imageIcon = [UIImageView new];
	imageIcon.image = [UIImage imageNamed:@"placeholder-empty-data"];
	[imageIcon sizeToFit];
	[self addSubview:imageIcon];
	_ivIcon = imageIcon;
	
	self.userInteractionEnabled = _lblHint.userInteractionEnabled = _ivIcon.userInteractionEnabled = NO;
	self.backgroundColor = _lblHint.backgroundColor = _ivIcon.backgroundColor = [UIColor clearColor];
	self.hidden = YES;
	
	[imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self);
		make.centerY.equalTo(self).offset(-20);
	}];
	
	[labelText mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self);
		make.centerY.equalTo(self).offset(20);
	}];	
}

- (void)setFrame:(CGRect)frame {
	
	if (frame.size.width <= 1) {
		frame.size.width = [[UIScreen mainScreen] bounds].size.width;
	}
	
	if (frame.size.height < _lblHint.bounds.size.height + _ivIcon.bounds.size.height) {
		frame.size.height = _lblHint.bounds.size.height + _ivIcon.bounds.size.height + ([UIScreen mainScreen].bounds.size.height * 0.618);
	}
	
	[super setFrame:frame];
	
	CGPoint center = CGPointZero;
	
	center.x = frame.size.width / 2;
	center.y = (frame.size.height / 2) - (_ivIcon.bounds.size.height / 2) - _lblHint.bounds.size.height;
	_ivIcon.center = center;
	
	center.x = frame.size.width / 2;
	center.y = _ivIcon.center.y + (_ivIcon.bounds.size.height / 2) + (_lblHint.bounds.size.height / 2) + 20;
	_lblHint.center = center;
	
}

+ (instancetype)view {
	return [[EmptyDataView alloc] initWithFrame:CGRectZero];
}

@end
