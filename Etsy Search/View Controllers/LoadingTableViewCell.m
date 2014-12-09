//
//  LoadingTableViewCell.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/9/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "LoadingTableViewCell.h"

@implementation LoadingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.activityIndicator startAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
