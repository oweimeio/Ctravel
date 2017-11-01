//
//  LYPicker.m
//  ygwjw
//
//  CREATED BY LUO YU ON 2016-08-12.
//  COPYRIGHT © 2016 HUAAO TECH. ALL RIGHTS RESERVED.
//

#import "LYPicker.h"
#import "PreHeader.h"

@interface LYPicker () <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIView *vPicker;
	UIPickerView *pvPicker;
	didSelectItem selectionBlock;
}
@end

@implementation LYPicker

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
	
	UIPickerView *piPicker = [[UIPickerView alloc] init];
	piPicker.frame = (CGRect){0, 44, WIDTH, WIDTH / 1.48148f};
	piPicker.dataSource = self;
	piPicker.delegate = self;
	piPicker.backgroundColor = [UIColor whiteColor];

	[viewPicker addSubview:piPicker];
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

#pragma mark - METHOD

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

- (void)setSelectBlock:(didSelectItem)selectBlock {
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
	
	if (_datasource != nil && [_datasource count] > 0 && _selectedIndex >= 0 && _selectedIndex < [_datasource count]) {
		selectionBlock(_selectedIndex, _datasource[_selectedIndex]);
	}
	
	[self dismiss];
}

#pragma mark - PROPERTY

- (NSInteger)selectedIndex {
	if (_datasource == nil || [_datasource count] == 0) {
		NSLog(@"\n\nLYPicker ERROR\n\tDATA SOURCE NIL\n");
		return -1;
	}
	return _selectedIndex;
}

- (void)setDatasource:(NSArray *)datasource {
	
	if (datasource == nil || [datasource isKindOfClass:[NSArray class]] == NO || [datasource count] == 0) {
		return;
	}
	
	_datasource = datasource;
	
	[pvPicker reloadAllComponents];
	
	_selectedIndex = 0;
	[pvPicker selectRow:0 inComponent:0 animated:NO];
}

- (void)setKeyTitle:(NSString *)keyTitle {
	
	if (keyTitle == nil || [keyTitle isEqualToString:@""]) {
		return;
	}
	
	_keyTitle = keyTitle;
	
	[pvPicker reloadAllComponents];
	_selectedIndex = 0;
	[pvPicker selectRow:0 inComponent:0 animated:NO];
}

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
	_selectedIndex = row;
}

#pragma mark | UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [_datasource count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (_keyTitle == nil || [_keyTitle isEqualToString:@""]) {
		NSLog(@"\n\nLYPicker ERROR\n\tPLEASE SET KEYTITLE PROPERTY FIRST\n");
		return @"";
	}
	
	return _datasource[row][_keyTitle];
}

@end
