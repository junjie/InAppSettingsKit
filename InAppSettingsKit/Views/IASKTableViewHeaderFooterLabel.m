//
//  IASKTableViewHeaderFooterLabel.m
//  Due2
//
//  Created by Lin Junjie on 28/10/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import "IASKTableViewHeaderFooterLabel.h"

@implementation IASKTableViewHeaderLabel

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		_transformTextToAllCaps = YES;
		self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		self.edgeInsets = UIEdgeInsetsMake(0, 15, 5, 15);
		self.textColor = IASKTableViewHeaderFooterLabelColor();
		self.numberOfLines = 1;
		self.lineBreakMode = NSLineBreakByTruncatingTail;
	}
	
	return self;
}

- (void)setText:(NSString *)text
{
	if (self.transformTextToAllCaps)
	{
		[super setText:[text uppercaseString]];
	}
	else
	{
		[super setText:text];
	}
}

@end

@implementation IASKTableViewFooterLabel

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
		self.edgeInsets = UIEdgeInsetsMake(4, 15, 20, 15);
		self.textColor = IASKTableViewHeaderFooterLabelColor();
		self.numberOfLines = 0;
		self.lineBreakMode = NSLineBreakByTruncatingTail;
	}
	
	return self;
}

- (void)setLabelFont:(UIFont *)labelFont
{
	[super setLabelFont:labelFont];
}

@end