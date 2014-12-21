//
//  IASKSpecifierValuesViewController.m
//  http://www.inappsettingskit.com
//
//  Copyright (c) 2009:
//  Luc Vandal, Edovia Inc., http://www.edovia.com
//  Ortwin Gentz, FutureTap GmbH, http://www.futuretap.com
//  All rights reserved.
// 
//  It is appreciated but not required that you give credit to Luc Vandal and Ortwin Gentz, 
//  as the original authors of this code. You can give credit in a blog post, a tweet or on 
//  a info page of your app. Also, the original authors appreciate letting them know if you use this code.
//
//  This code is licensed under the BSD license that is available at: http://www.opensource.org/licenses/bsd-license.php
//

#import "IASKSpecifierValuesViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "IASKSettingsStoreUserDefaults.h"
#import "kIASKPSGenericTableViewCell.h"
#import "IASKTableViewHeaderFooterLabel.h"

#define kCellValue      @"kCellValue"

@interface IASKSpecifierValuesViewController()
- (void)userDefaultsDidChange;
@property (nonatomic, strong) IASKTableViewFooterLabel *footerLabel;
@end

@implementation IASKSpecifierValuesViewController

@synthesize tableView=_tableView;
@synthesize currentSpecifier=_currentSpecifier;
@synthesize checkedItem=_checkedItem;
@synthesize settingsReader = _settingsReader;
@synthesize settingsStore = _settingsStore;

- (void) updateCheckedItem {
    NSInteger index;
	
	// Find the currently checked item
    if([self.settingsStore objectForKey:[_currentSpecifier key]]) {
      index = [[_currentSpecifier multipleValues] indexOfObject:[self.settingsStore objectForKey:[_currentSpecifier key]]];
    } else {
      index = [[_currentSpecifier multipleValues] indexOfObject:[_currentSpecifier defaultValue]];
    }
	[self setCheckedItem:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (id<IASKSettingsStore>)settingsStore {
    if(_settingsStore == nil) {
        _settingsStore = [[IASKSettingsStoreUserDefaults alloc] init];
    }
    return _settingsStore;
}

- (void)loadView
{
	_statusBarStyle = UIStatusBarStyleDefault;
	
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.view = _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    if (_currentSpecifier) {
        [self setTitle:[_currentSpecifier title]];
        [self updateCheckedItem];
    }
    
    if (_tableView) {
        [_tableView reloadData];

		// Make sure the currently checked item is visible
        [_tableView scrollToRowAtIndexPath:[self checkedItem] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[_tableView flashScrollIndicators];
	[super viewDidAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userDefaultsDidChange)
												 name:NSUserDefaultsDidChangeNotification
											   object:[NSUserDefaults standardUserDefaults]];
}

- (void)viewDidDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.tableView = nil;
}

#pragma mark -
#pragma mark UITableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_currentSpecifier multipleValuesCount];
}

- (void)selectCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	IASK_IF_PRE_IOS7([[cell textLabel] setTextColor:kIASKgrayBlueColor];);
}

- (void)deselectCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	IASK_IF_PRE_IOS7([[cell textLabel] setTextColor:[UIColor darkTextColor]];);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_currentSpecifier footerText];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	IASKTableViewFooterLabel *footerView = [self footerViewForTableView:tableView section:section];
	
	if (!footerView)
	{
		return UITableViewAutomaticDimension;
	}
	
	[footerView fitToWidth:CGRectGetWidth(tableView.frame)];
	return CGRectGetHeight(footerView.frame);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return [self footerViewForTableView:tableView section:section];
}

- (IASKTableViewFooterLabel *)footerViewForTableView:(UITableView *)tableView section:(NSInteger)section
{
	NSString *footerText = [self tableView:tableView titleForFooterInSection:section];
	
	if (![footerText length])
	{
		return nil;
	}
	
	if (!self.footerLabel)
	{
		IASKTableViewFooterLabel *footerLabel = [[IASKTableViewFooterLabel alloc] initWithFrame:CGRectZero];
		footerLabel.font = self.customFooterFont;
		footerLabel.text = footerText;
		
		self.footerLabel = footerLabel;
	}
	
	return self.footerLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:kCellValue];
    NSArray *titles         = [_currentSpecifier multipleTitles];
	
    if (!cell) {
		cell = [[kIASKPSGenericTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellValue textLabelFont:self.customTitleValueCellTitleFont valueLabelFont:self.customTitleValueCellValueFont];
    }
	
	if ([indexPath isEqual:[self checkedItem]]) {
		[self selectCell:cell];
    } else {
        [self deselectCell:cell];
    }
	
	@try {
		[[cell textLabel] setText:[self.settingsReader titleForStringId:[titles objectAtIndex:indexPath.row]]];
	}
	@catch (NSException * e) {}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath == [self checkedItem]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    NSArray *values         = [_currentSpecifier multipleValues];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self deselectCell:[tableView cellForRowAtIndexPath:[self checkedItem]]];
    [self selectCell:[tableView cellForRowAtIndexPath:indexPath]];
    [self setCheckedItem:indexPath];
	
	id oldValue = [self.settingsStore objectForKey:[_currentSpecifier key]];
	
    [self.settingsStore setObject:[values objectAtIndex:indexPath.row] forKey:[_currentSpecifier key]];
	[self.settingsStore synchronize];
	
	NSDictionary *userInfo =
	@{ [_currentSpecifier key] : [values objectAtIndex:indexPath.row],
	   kIASKAppSettingChangedOldKey : oldValue };
	
    [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged
                                                        object:[_currentSpecifier key]
													  userInfo:userInfo];
}

- (CGSize)contentSizeForViewInPopover {
    return [[self view] sizeThatFits:CGSizeMake(320, 2000)];
}


#pragma mark Notifications

- (void)userDefaultsDidChange {
	NSIndexPath *oldCheckedItem = self.checkedItem;
	if(_currentSpecifier) {
		[self updateCheckedItem];
	}
	
	self.footerLabel = nil;
	
	// only reload the table if it had changed; prevents animation cancellation
	if (![self.checkedItem isEqual:oldCheckedItem]) {
		[_tableView reloadData];
	}
}

#pragma mark - Header Footer

- (void)clearHeaderFooterCache
{
	self.footerLabel = nil;
}

- (void)setCustomTitleValueCellTitleFont:(UIFont *)customTitleValueCellTitleFont
{
	if (_customTitleValueCellTitleFont != customTitleValueCellTitleFont)
	{
		_customTitleValueCellTitleFont = customTitleValueCellTitleFont;
		[self.tableView reloadData];
	}
}

- (void)setCustomTitleValueCellValueFont:(UIFont *)customTitleValueCellValueFont
{
	if (_customTitleValueCellValueFont != customTitleValueCellValueFont)
	{
		_customTitleValueCellValueFont = customTitleValueCellValueFont;
		[self.tableView reloadData];
	}
}

- (void)setCustomHeaderFont:(UIFont *)customHeaderFont
{
	if (_customHeaderFont != customHeaderFont)
	{
		_customHeaderFont = customHeaderFont;
		[self clearHeaderFooterCache];
	}
}

- (void)setCustomFooterFont:(UIFont *)customFooterFont
{
	if (_customFooterFont != customFooterFont)
	{
		_customFooterFont = customFooterFont;
		[self clearHeaderFooterCache];
	}
}

#pragma mark - Status Bar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return self.statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
	if (_statusBarStyle != statusBarStyle)
	{
		_statusBarStyle = statusBarStyle;
		[self setNeedsStatusBarAppearanceUpdate];
	}
}


@end
