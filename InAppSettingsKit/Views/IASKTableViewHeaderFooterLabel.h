//
//  IASKTableViewHeaderFooterLabel.h
//  Due2
//
//  Created by Lin Junjie on 28/10/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//

#import "JJInsetLabel.h"

static inline UIColor* IASKTableViewHeaderFooterLabelColor() { return [UIColor colorWithRed:109/255.0 green:109/255.0 blue:114/255.0 alpha:1]; }

@interface IASKTableViewHeaderLabel : JJInsetLabel

// Default edge insets: UIEdgeInsetsMake(0, 15, 5, 15);

/// Default: YES
@property (nonatomic) BOOL transformTextToAllCaps;

@end

@interface IASKTableViewFooterLabel : JJInsetLabel

// Default edge insets: UIEdgeInsetsMake(4, 15, 20, 15);

@end