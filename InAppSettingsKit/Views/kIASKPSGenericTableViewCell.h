//
//  kIASKPSGenericTableViewCell.h
//  Due2
//
//  Created by Lin Junjie on 28/10/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kIASKPSGenericTableViewCell : UITableViewCell

@property (strong, nonatomic) UIColor *titleLabelColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *valueLabelColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier textLabelFont:(UIFont *)textLabelFont valueLabelFont:(UIFont *)valueLabelFont;

@end
