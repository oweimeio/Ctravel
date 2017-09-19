//
//  HAAddressPicker.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-28.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAAddressPicker.h"
#import <HACore/HACoreHeader.h>
#import <HACore/HACoreAPI.h>

@interface HAAddressPicker () <UITableViewDelegate, UITableViewDataSource> {
	
	__weak UILabel *lblTitle;
	__weak UITableView *tbAddress;
	
	__weak UIButton *btnCancel;
	__weak UIButton *btnConfirm;
	
	__weak UIActivityIndicatorView *indicator;
	
	didSelectAddress selectionBlock;
	
	NSArray *address;
	NSString *confirmed;
}

@end

@interface NSArray (HAAddressPicker)
- (NSArray *)groupedForHAAddressPicker;
@end

@implementation HAAddressPicker

// MARK: - ACTION

- (void)cancelButtonPressed:(UIButton *)button {
	[self dismiss];
}

- (void)confirmButtonPressed:(UIButton *)button {
	selectionBlock(@{@"success":@"yes"});
	[self dismiss];
}

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	frame = [UIScreen mainScreen].bounds;
	if (self = [super initWithFrame:frame]) {
		
		self.title = @"请选择地址";
		
		NSDictionary *conf = [self configurations];
		NSString *confValue = @"conf-value";
		
		{
			UILabel *labelTitle = [[UILabel alloc] init];
			labelTitle.frame = (CGRect){padding, 44, vCont.bounds.size.width - padding, 44};
			labelTitle.text = @"请选择地址..";
			labelTitle.numberOfLines = 0;
			[vCont addSubview:labelTitle];
			lblTitle = labelTitle;
			
			/*
			UIView *line = [[UIView alloc] init];
			line.userInteractionEnabled = NO;
			line.backgroundColor = [UIColor groupTableViewBackgroundColor];
			line.frame = (CGRect){0, 88 - 1 / [UIScreen mainScreen].scale, vCont.bounds.size.width, 1 / [UIScreen mainScreen].scale};
			[vCont addSubview:line];
			*/
		}
		
		{
			UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
			[indicatorView sizeToFit];
			indicatorView.center = (CGPoint){vCont.bounds.size.width / 2, (vCont.bounds.size.height) / 2};
			[indicatorView startAnimating];
			[vCont addSubview:indicatorView];
			indicator = indicatorView;
		}
		
		{
			UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
			table.backgroundColor = [UIColor whiteColor];
			table.separatorStyle = UITableViewCellSeparatorStyleNone;
			table.frame = (CGRect){0, 88, vCont.bounds.size.width, vCont.bounds.size.height - (44 * 3)};
			table.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0, 0, vCont.bounds.size.width, 0.01f}];
			table.delegate = self;
			table.dataSource = self;
			[table registerNib:[UINib nibWithNibName:@"HAAddressCell"
											  bundle:[NSBundle bundleWithIdentifier:LIB_HACONF_BUNDLE_ID]]
		forCellReuseIdentifier:HAAddressCellIdentifier];
			[vCont addSubview:table];
			tbAddress = table;
		}
		
		{
			UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
			[buttonCancel setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
			buttonCancel.frame = (CGRect){0, vCont.bounds.size.height - 44, vCont.bounds.size.width / 2, 44};
			[buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
			[buttonCancel addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[vCont addSubview:buttonCancel];
			btnCancel = buttonCancel;
		}
		
		{
			UIButton *buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
			[buttonConfirm setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
			buttonConfirm.frame = (CGRect){vCont.bounds.size.width / 2, vCont.bounds.size.height - 44, vCont.bounds.size.width / 2, 44};
			[buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
			[buttonConfirm addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[vCont addSubview:buttonConfirm];
			btnConfirm = buttonConfirm;
		}
	}
	return self;
}

+ (void)showPickerWithSelected:(didSelectAddress)addressBlock {
	
	if ([[HAApp current] isLoggedIn] == NO) {
		return;
	}
	
	HAAddressPicker *picker = [[HAAddressPicker alloc] init];
	[picker setSelectedBlock:addressBlock];
	[picker show];
	[picker requestAddress:@"4028876d5a3f4efd015a3f4f49760000"];
}

// MARK: - METHOD

- (void)setSelectedBlock:(didSelectAddress)addressBlock {
	selectionBlock = addressBlock;
}

// MARK: | PRIVATE METHOD

- (void)switchEnable:(BOOL)enable {
	
	if (enable == NO) {
		tbAddress.userInteractionEnabled = NO;
		indicator.hidden = NO;
		btnConfirm.enabled = NO;
	} else {
		tbAddress.userInteractionEnabled = YES;
		[tbAddress reloadData];
		tbAddress.hidden = NO;
		indicator.hidden = YES;
		btnConfirm.enabled = YES;
	}
}

- (void)resetFrames {
	
	CGFloat labelPadding = 44 - 21;
	lblTitle.frame = (CGRect){padding, 44 + (labelPadding / 2), vCont.bounds.size.width - padding, [lblTitle.text heightWithFont:lblTitle.font andFixedWidth:vCont.bounds.size.width - 44]};
	
	tbAddress.frame = (CGRect){0, CGRectGetMaxY(lblTitle.frame) + (labelPadding / 2), vCont.bounds.size.width, vCont.bounds.size.height - 44 - CGRectGetMaxY(lblTitle.frame) - (labelPadding / 2) - 44};
}

// MARK: | NETWORKING

- (void)requestAddress:(NSString *)rootID {
	
//	tbAddress.hidden = YES;
//	indicator.hidden = NO;
	[self switchEnable:NO];
	
	NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
	[param setObject:[HAApp current].atoken forKey:@"token"];
	
	if (rootID != nil) {
		[param setObject:rootID forKey:@"parentId"];
	}
	
	[[HACoreAPI core] GETURLString:@"/area/findByParent.do" withParameters:param success:^(id ret) {
//		NSLog(@"%@", ret);
		if ([ret hasObjectWithKey:@"data"] && [ret[@"data"] count] > 0) {
			address = [ret[@"data"] groupedForHAAddressPicker];
			[self switchEnable:YES];
		} else {
			// DO NOTHING
			[self switchEnable:YES];
		}
		
	} error:^(NSInteger code, NSString *msg, id ret) {
		
	} failure:^(NSError *error) {
		
	}];
}

// MARK: - OVERRIDE

// MARK: - DELEGATE

// MARK: | UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
	
//	[tableView deselectRowAtIndexPath:idp animated:YES];
	
	NSDictionary *selected = address[idp.section][HA_SUB_ARRAY][idp.row];
	
	[self requestAddress:selected[@"id"]];
	
	if (confirmed == nil) {
		confirmed = selected[@"name"];
	} else {
		confirmed = [confirmed stringByAppendingFormat:@"-%@", selected[@"name"]];
	}
	
	lblTitle.text = confirmed;
	
	[self resetFrames];
	
	/*
	lblTitle.text = [NSString stringWithFormat:@"%@%@%@",
					 confirmed != nil ? confirmed : @"",
					 confirmed != nil ? @"-" : @"",
					 selected[@"name"]];
	*/
}

// MARK: | UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [address count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [address[section][HA_SUB_ARRAY] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	
	HAAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:HAAddressCellIdentifier forIndexPath:idp];
	cell.lblTitle.text = address[idp.section][HA_SUB_ARRAY][idp.row][@"name"];
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [HAAddressCellHeader headerWithTitle:address[section][HA_TITLE] andWidth:vCont.bounds.size.width];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

@end

// MARK: - ARRAY ADDRESS CATEGORY

@implementation NSArray (HAAddressPicker)

- (NSArray *)groupedForHAAddressPicker {
	
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:1];
	
	NSArray *sorted = [self sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
	
	for (NSDictionary *one in sorted) {
		
		NSString *indexTitle = [one[@"name"] indexLetter];
		
		BOOL has = NO;
		for (int i = 0; i < [result count]; i++) {
			
			NSDictionary *subone = result[i];
			
			if ([subone[HA_TITLE] isEqualToString:indexTitle]) {
				// APPEND
				NSMutableArray *newone = [subone[HA_SUB_ARRAY] mutableCopy];
				[newone addObject:one];
				[result replaceObjectAtIndex:i withObject:@{HA_TITLE:indexTitle, HA_SUB_ARRAY:[NSArray arrayWithArray:newone],}];
				
				// BREAK INNER LOOP
				has = YES;
				newone = nil;
				break;
			}
		}
		
		if (has == NO) {
			// ADD NEW GROUP
			[result addObject:@{HA_TITLE:indexTitle, HA_SUB_ARRAY:@[one,],}];
		}
	}
	
	return [NSArray arrayWithArray:result];
}

@end

// MARK: - ADDRESS CELL

NSString *const HAAddressCellIdentifier = @"HAAddressCellIdentifier";

@implementation HAAddressCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// INITIALIZATION CODE
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	_lblSelection.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// CONFIGURE THE VIEW FOR THE SELECTED STATE
	
	_lblSelection.text = selected ? @"✔️" : @"";
}

@end

// MARK: -

@implementation HAAddressCellHeader

- (instancetype)initWithTitle:(NSString *)title andWidth:(CGFloat)width {
	CGRect frame = (CGRect){0, 0, width, 40};
	if (self = [super initWithFrame:frame]) {
		
		self.backgroundColor = [UIColor clearColor];
		
		UIView *line = [[UIView alloc] init];
		line.frame = (CGRect){0, 0, frame.size.width, 1 / [UIScreen mainScreen].scale};
		line.userInteractionEnabled = NO;
		line.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:line];
		
		UILabel *label = [[UILabel alloc] init];
		label.frame = (CGRect){20, 16, frame.size.width - 20, 16};
		label.font = [UIFont systemFontOfSize:14];
		label.textColor = [UIColor darkGrayColor];
		label.text = title;
		[self addSubview:label];
	}
	return self;
}

+ (instancetype)headerWithTitle:(NSString *)title andWidth:(CGFloat)width {
	return [[HAAddressCellHeader alloc] initWithTitle:title andWidth:width];
}

@end
