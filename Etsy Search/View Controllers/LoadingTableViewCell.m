//
//  LoadingTableViewCell.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/9/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "LoadingTableViewCell.h"

@interface LoadingTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoadingTableViewCell

#pragma mark - Public methods

- (void)reset
{
    self.instructionLabel.text = @"Pull down to load more";
    [self.activityIndicator stopAnimating];
}

- (void)indicateThresholdReached
{
    self.instructionLabel.text = @"Let go to learn more";
    [self.activityIndicator stopAnimating];
}

- (void)startLoading
{
    self.instructionLabel.text = @"Loading...";
    [self.activityIndicator startAnimating];
}

#pragma mark - Private methods

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
