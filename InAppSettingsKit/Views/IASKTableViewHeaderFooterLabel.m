//
//  IASKTableViewHeaderFooterLabel.m
//  Due2
//
//  Created by Lin Junjie on 28/10/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import "IASKTableViewHeaderFooterLabel.h"

CGFloat const kIASKTableViewHeaderLabelInsetsTop = 0.0;
CGFloat const kIASKTableViewHeaderLabelInsetsLeft = 15.0;
CGFloat const kIASKTableViewHeaderLabelInsetsBottomMultiple = 0.25;
CGFloat const kIASKTableViewHeaderLabelInsetsRight = 15.0;

CGFloat const kIASKTableViewFooterLabelInsetsTopMultiple = 0.25;
CGFloat const kIASKTableViewFooterLabelInsetsLeft = 15.0;
CGFloat const kIASKTableViewFooterLabelInsetsBottomMultiple = 1.25;
CGFloat const kIASKTableViewFooterLabelInsetsRight = 15.0;

@implementation IASKTableViewHeaderLabel

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		_transformTextToAllCaps = YES;
		self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		self.textColor = IASKTableViewHeaderFooterLabelColor();
		self.numberOfLines = 0;
		self.lineBreakMode = NSLineBreakByTruncatingTail;
		
		[self updateEdgeInsets];
	}
	
	return self;
}

- (void)setLabelFont:(UIFont *)labelFont
{
	[super setLabelFont:labelFont];
	[self updateEdgeInsets];
}

- (void)setFont:(UIFont *)font
{
	[super setFont:font];
	[self updateEdgeInsets];
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

- (void)updateEdgeInsets
{
	self.edgeInsets = UIEdgeInsetsMake(kIASKTableViewHeaderLabelInsetsTop, kIASKTableViewHeaderLabelInsetsLeft, ceil(self.font.pointSize *kIASKTableViewHeaderLabelInsetsBottomMultiple), kIASKTableViewHeaderLabelInsetsRight);
}

@end

@implementation IASKTableViewFooterLabel

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
		self.textColor = IASKTableViewHeaderFooterLabelColor();
		self.numberOfLines = 0;
		self.lineBreakMode = NSLineBreakByTruncatingTail;
		
		[self updateEdgeInsets];
	}
	
	return self;
}

- (void)setLabelFont:(UIFont *)labelFont
{
	[super setLabelFont:labelFont];
	[self updateEdgeInsets];
}

- (void)setFont:(UIFont *)font
{
	[super setFont:font];
	[self updateEdgeInsets];
}

- (void)updateEdgeInsets
{
	self.edgeInsets = UIEdgeInsetsMake(ceil(self.font.pointSize * kIASKTableViewFooterLabelInsetsTopMultiple), kIASKTableViewFooterLabelInsetsLeft, ceil(self.font.pointSize * kIASKTableViewFooterLabelInsetsBottomMultiple), kIASKTableViewFooterLabelInsetsRight);
}

@end