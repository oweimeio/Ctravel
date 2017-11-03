//
//  LYPicker.m
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-12.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import "LYDatePicker.h"
#import "PreHeader.h"

@interface LYDatePicker () {
	UIView *vPicker;
	UIDatePicker *pvPicker;
	didSelectDate selectionBlock;
	NSDate *selectedDate;
}
@end

@implementation LYDatePicker

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size.width = WIDTH;
	if (self = [super initWithFrame:frame]) {
		[self initial];
		[self setFrame:frame];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	self.hidden = YES;
	self.alpha = 0;
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.61];
	
	_removeWhenDismissed = NO;
	
	[self bk_addEventHandler:^(id sender) {
		[self dismiss];
	} forControlEvents:UIControlEventTouchDown];
	
	UIView *viewPicker = [UIView new];
	viewPicker.backgroundColor = [UIColor whiteColor];

	[self addSubview:viewPicker];
	vPicker = viewPicker;
	
	UIDatePicker *piPicker = [[UIDatePicker alloc] init];
	piPicker.frame = (CGRect){0, 44, WIDTH, WIDTH / 1.48148f};
	piPicker.backgroundColor = [UIColor whiteColor];
	piPicker.date = [NSDate new];
	piPicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
	piPicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
	piPicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
	piPicker.datePickerMode = UIDatePickerModeTime; // 设置样式
	[piPicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
	[viewPicker addSubview:piPicker];
	selectedDate = piPicker.date;
	pvPicker = piPicker;
	
	viewPicker.frame = (CGRect){0, 0, WIDTH, piPicker.frame.size.height + 44};
	
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, WIDTH, 44}];
	UIBarButtonItem *tbCancel = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemCancel handler:^(id sender) {
		[self dismiss];
	}];
	UIBarButtonItem *tbSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *tbDone = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
		[self done];
	}];
	[toolbar setItems:@[tbCancel, tbSpace, tbDone,]];
	[viewPicker addSubview:toolbar];
}

- (void)setFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size.width = WIDTH;
	vPicker.center = (CGPoint){frame.size.width / 2, frame.origin.y + (vPicker.frame.size.height / 2)};
	[super setFrame:frame];
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    _datePickerMode = datePickerMode;
    pvPicker.datePickerMode = datePickerMode;
}

#pragma mark - METHOD

- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
	selectedDate = [sender date];
	NSLog(@"%@", [sender date]);
}

- (void)show {
	CGFloat const ANIMATE = 0.25f;
	if ([self superview] != nil) {
		[[self superview] bringSubviewToFront:self];
		self.frame = (CGRect){CGPointZero, [self superview].frame.size};
	}
	
	self.alpha = 0;
	self.hidden = NO;
	
	vPicker.center = (CGPoint){self.frame.size.width / 2, self.frame.size.height + (vPicker.frame.size.height / 2)};
	CGPoint center = (CGPoint){self.frame.size.width / 2, self.frame.size.height - (vPicker.frame.size.height / 2)};
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		vPicker.center = center;
		self.alpha = 1;
	} completion:^(BOOL finished) {
		
	}];
	
}

- (void)showInView:(UIView *)view {
	[view addSubview:self];
	[self show];
}

- (void)setSelectBlock:(didSelectDate)selectBlock {
	selectionBlock = selectBlock;
}

#pragma mark | PRIVATE METHOD

- (void)dismiss {
	CGFloat const ANIMATE = 0.25f;
	self.hidden = NO;
	self.alpha = 1;
	CGPoint center = vPicker.center;
	center.y = self.frame.size.height + center.y;
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.alpha = 0;
		vPicker.center = center;
	} completion:^(BOOL finished) {
		self.hidden = YES;
		vPicker.center = (CGPoint){WIDTH / 2, self.frame.size.height - (vPicker.frame.size.height / 2)};
		
		if (_removeWhenDismissed) {
			[self removeFromSuperview];
		}
	}];
	
}

- (void)done {

	selectionBlock(selectedDate);
	
	[self dismiss];
}

#pragma mark - PROPERTY


- (void)setTintColor:(UIColor *)tintColor {
	
	for (id one in [vPicker subviews]) {
		if ([one isKindOfClass:[UIToolbar class]]) {
			for (UIBarButtonItem *item in [one items]) {
				item.tintColor = tintColor;
			}
		}
	}
}

@end
