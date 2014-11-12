//
//  kIASKPSGenericTableViewCell.m
//  Due2
//
//  Created by Lin Junjie on 28/10/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import "kIASKPSGenericTableViewCell.h"

@implementation kIASKPSGenericTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier textLabelFont:(UIFont *)textLabelFont valueLabelFont:(UIFont *)valueLabelFont
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self)
	{
		if (textLabelFont)
		{
			_textLabelFont = textLabelFont;
			self.textLabel.font = textLabelFont;
		}
		
		if (valueLabelFont)
		{
			_valueLabelFont = valueLabelFont;
			self.detailTextLabel.font = valueLabelFont;
		}
	}
	
	return self;
}

#pragma mark - UIAppearance

- (UIColor *)titleLabelColor
{
	return self.textLabel.textColor;
}

- (UIColor *)valueLabelColor
{
	return self.detailTextLabel.textColor;
}

- (UIColor *)selectedBackgroundColor
{
	return self.selectedBackgroundView.backgroundColor;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
	self.textLabel.textColor = titleLabelColor;
}

- (void)setValueLabelColor:(UIColor *)valueLabelColor
{
	self.detailTextLabel.textColor = valueLabelColor;
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
	BOOL needsSetBackgroundView = NO;
	UIView *selectedBackgroundView = self.selectedBackgroundView;

	// Default selectedBackgroundView is UITableViewCellSelectedBackground
	if (!selectedBackgroundView ||
		![selectedBackgroundView isMemberOfClass:[UIView class]])
	{
		selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
		needsSetBackgroundView = YES;
	}
	
	selectedBackgroundView.backgroundColor = selectedBackgroundColor;
	
	if (needsSetBackgroundView)
	{
		self.selectedBackgroundView = selectedBackgroundView;
	}
}

#pragma mark - Fonts

- (void)setTextLabelFont:(UIFont *)textLabelFont
{
	if (_textLabelFont != textLabelFont)
	{
		_textLabelFont = textLabelFont;
		self.textLabel.font = textLabelFont;
	}
}

- (void)setValueLabelFont:(UIFont *)valueLabelFont
{
	if (_valueLabelFont != valueLabelFont)
	{
		_valueLabelFont = valueLabelFont;
		self.detailTextLabel.font = valueLabelFont;
	}
}

#pragma mark - 

- (void)prepareForReuse
{
	self.textLabel.font = self.textLabelFont;
	self.detailTextLabel.font = self.valueLabelFont;
}

@end
