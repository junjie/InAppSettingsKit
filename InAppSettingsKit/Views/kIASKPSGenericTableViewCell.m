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
			self.textLabel.font = textLabelFont;
		}
		
		if (valueLabelFont)
		{
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

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
	self.textLabel.textColor = titleLabelColor;
}

- (void)setValueLabelColor:(UIColor *)valueLabelColor
{
	self.detailTextLabel.textColor = valueLabelColor;
}

@end
