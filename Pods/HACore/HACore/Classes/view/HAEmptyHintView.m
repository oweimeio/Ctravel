//
//  HAEmptyHintView.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-04-06.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAEmptyHintView.h"
#import "UIColor+HACore.h"
#import "LYCategory.h"
#import <HACore/HACoreHeader.h>

@implementation HAEmptyHintView

// MARK: - INITIAL

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self initial];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	frame.size.width = WIDTH;
	frame.origin.x = 0;
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	self.clipsToBounds = YES;
	
	if (_lblHint == nil) {
		UILabel *labelHint = [[UILabel alloc] init];
		labelHint.text = [[HACore core] valueForConfWithKey:@"core-view-empty-data-hint"];
		labelHint.textColor = [UIColor coreColor:@"#c5c5c5" alpha:1];
		labelHint.font = [UIFont systemFontOfSize:15];
		labelHint.textAlignment = NSTextAlignmentCenter;
		[labelHint sizeToFit];
		[self addSubview:labelHint];
		_lblHint = labelHint;
	}
	
	if (_ivIcon == nil) {
		UIImageView *imageIcon = [[UIImageView alloc] init];
		imageIcon.frame = (CGRect){0, 0, WIDTH, 50};
		[imageIcon setContentMode:UIViewContentModeCenter];
		[self addSubview:imageIcon];
		imageIcon.image = [UIImage imageNamed:[[HACore core] valueForConfWithKey:@"core-view-empty-data-imagename"]];
		_ivIcon = imageIcon;
	}
}

- (void)setFrame:(CGRect)frame {
	
	frame.origin.x = 0;
	frame.size.width = WIDTH;
	
	_ivIcon.frame = (CGRect){0, 0, WIDTH, frame.size.height - 10 - 20};
//	_ivIcon.contentMode = UIViewContentModeScaleAspectFit;
	
	_lblHint.frame = (CGRect){10, frame.size.height - 10 - 20, WIDTH - 20, 20};
	
	[super setFrame:frame];
}

+ (instancetype)view {
	return [[HAEmptyHintView alloc] initWithFrame:CGRectZero];
}

+ (instancetype)viewWithTitle:(NSString *)title andIconNamed:(NSString *)imageName {
	HAEmptyHintView *emptyview = [[HAEmptyHintView alloc] initWithFrame:CGRectZero];
	
	if (title != nil && [title isKindOfClass:[NSString class]]) {
		emptyview.lblHint.text = title;
	} else {
		emptyview.lblHint.text = [[HACore core] valueForConfWithKey:@"core-view-empty-data-hint"];
	}
	
	UIImage *image = [UIImage imageNamed:imageName];
	emptyview.ivIcon.image = image;
	
	emptyview.frame = (CGRect){0, 0, WIDTH, image.size.height + 10 + 20};
	
	return emptyview;
}

+ (instancetype)viewWithTitle:(NSString *)title andIcon:(UIImage *)image {
	HAEmptyHintView *emptyview = [[HAEmptyHintView alloc] initWithFrame:CGRectZero];
	
	if (title != nil && [title isKindOfClass:[NSString class]]) {
		emptyview.lblHint.text = title;
	} else {
		emptyview.lblHint.text = [[HACore core] valueForConfWithKey:@"core-view-empty-data-hint"];
	}
	
	emptyview.ivIcon.image = image;
	
	emptyview.frame = (CGRect){0, 0, WIDTH, image.size.height + 10 + 20};
	
	return emptyview;
}

- (void)centerInContainer {
	if ([self superview] == nil) {
		return;
	}
	
	CGSize contsize = [self superview].bounds.size;
	
	self.center = (CGPoint){contsize.width / 2.0f, contsize.height / 2.0f};
	
	[self syncValues];
}

- (void)syncValues {
	
	if (_hint != nil) {
		_lblHint.text = _hint;
	} else {
		_lblHint.text = [[HACore core] valueForConfWithKey:@"core-view-empty-data-hint"];
	}
	
	if (_hintImageName != nil) {
		_ivIcon.image = [UIImage imageNamed:_hintImageName];
	} else {
		_ivIcon.image = [UIImage imageNamed:[[HACore core] valueForConfWithKey:@"core-view-empty-data-imagename"]];
	}
	
	CGRect rect = self.frame;
	self.frame = rect;
}

@end
