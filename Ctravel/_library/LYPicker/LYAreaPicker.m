//
//  LYAreaPicker.m
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-27.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import "LYAreaPicker.h"
#import "PreHeader.h"

@interface LYAreaPicker () <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIView *vPicker;
	UIPickerView *picker;
	didSelectArea selectionBlock;
	NSArray *provinces, *cities, *areas;
}

@end

@implementation LYAreaPicker

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
	
	provinces = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RealAreaList" ofType:@"plist"]];
	cities = provinces[0][@"cities"];
	areas = cities[0][@"areas"];
	
	_province = provinces[0][@"province"];
	_city = cities[0][@"city"];
	_area = areas[0];
	_zipCode = cities[0][@"zip"];
	
	[self bk_addEventHandler:^(id sender) {
		[self dismiss];
	} forControlEvents:UIControlEventTouchDown];
	
	UIView *viewPicker = [UIView new];
	viewPicker.backgroundColor = [UIColor whiteColor];
	[self addSubview:viewPicker];
	vPicker = viewPicker;
	
	UIPickerView *piArea = [[UIPickerView alloc] init];
	piArea.frame = (CGRect){0, 44, WIDTH, WIDTH / 1.48148f};
	piArea.dataSource = self;
	piArea.delegate = self;
	piArea.backgroundColor = [UIColor whiteColor];
	[viewPicker addSubview:piArea];
	picker = piArea;
	[picker reloadAllComponents];
//	[picker selectRow:0 inComponent:0 animated:NO];
	
	viewPicker.frame = (CGRect){0, 0, WIDTH, picker.frame.size.height + 44};
	
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, WIDTH, 44}];
	UIBarButtonItem *tbCancel = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemCancel handler:^(id sender) {
		[self dismiss];
	}];
	UIBarButtonItem *tbSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *tbDone = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
		[self done];
	}];
	tbCancel.tintColor = tbDone.tintColor = [UIColor blueColor];
	[toolbar setItems:@[tbCancel, tbSpace, tbDone,]];
	[viewPicker addSubview:toolbar];

}

- (void)setFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size.width = WIDTH;
	vPicker.center = (CGPoint){frame.size.width / 2, frame.origin.y + (vPicker.frame.size.height / 2)};
	[super setFrame:frame];
}

#pragma mark - METHOD
CGFloat const ANIMATE = 0.25f;
- (void)show {
	
	[[self superview] bringSubviewToFront:self];
	self.frame = (CGRect){CGPointZero, [self superview].frame.size};
	
	self.alpha = 0;
	self.hidden = NO;
	
	vPicker.center = (CGPoint){self.frame.size.width / 2, self.frame.size.height + (vPicker.frame.size.height / 2)};
	CGPoint center = (CGPoint){self.frame.size.width / 2, self.frame.size.height - (vPicker.frame.size.height / 2)};
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		vPicker.center = center;
		self.alpha = 1;
	} completion:^(BOOL finished) {}];
	
}

- (void)showInView:(UIView *)view {
	
	if ([self superview] == nil) {
		[view addSubview:self];
	}
	
	[self show];
}

- (void)setSelectBlock:(didSelectArea)selectBlock {
	selectionBlock = selectBlock;
}

#pragma mark | PRIVATE METHOD

- (void)dismiss {
	
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

	selectionBlock(_province, _city, _area, _zipCode);

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

#pragma mark - DELEGATE

#pragma mark | UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	if (component == 0) {
		cities = provinces[row][@"cities"];
		areas = cities[0][@"areas"];
		[pickerView selectRow:0 inComponent:1 animated:NO];
		[pickerView selectRow:0 inComponent:2 animated:NO];
		[pickerView reloadComponent:1];
		[pickerView reloadComponent:2];
	} else if (component == 1) {
		areas = cities[row][@"areas"];
		[pickerView selectRow:0 inComponent:2 animated:NO];
		[pickerView reloadComponent:2];
	}
	
	[cities count] == 0 ? cities = nil : 0;
	[areas count] == 0 ? areas = nil : 0;

	_province = provinces[[pickerView selectedRowInComponent:0]][@"province"];
	_city = cities[[pickerView selectedRowInComponent:1]][@"city"];
	_zipCode = cities[[pickerView selectedRowInComponent:1]][@"zip"];
	_area = areas[[pickerView selectedRowInComponent:2]];
}

#pragma mark | UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	NSInteger rows = 0;

	switch (component) {
		case 0: {
			rows = [provinces count];
		} break;
		case 1: {
			rows = [cities count];
		} break;
		case 2: {
			rows = [areas count];
		} break;
		default:
			break;
	}
	
	return rows;
}

/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	NSString *title = @"";
	
	switch (component) {
		case 0: {
			title = provinces[row][@"province"];
		} break;
		case 1: {
			title = cities[row][@"city"];
		} break;
		case 2: {
			title = areas[row];
		} break;
		default:
			break;
	}
	return title;
}
*/

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *title = @"";
	
	switch (component) {
		case 0: {
			title = provinces[row][@"province"];
		} break;
		case 1: {
			title = cities[row][@"city"];
		} break;
		case 2: {
			title = areas[row];
		} break;
		default:
			break;
	}
	return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],}];
}

@end
