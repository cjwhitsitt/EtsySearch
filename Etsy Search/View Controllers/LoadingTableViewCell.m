//
//  LoadingTableViewCell.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/9/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "LoadingTableViewCell.h"

@interface LoadingTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *pullDownInstructionLabel;

@property (weak, nonatomic) IBOutlet UILabel *letGoInstructionlabel;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoadingTableViewCell

#pragma mark - Public methods

- (void)reset
{
    // what should be done here?
    [self shouldBeLoading:NO];
    self.pullDownInstructionLabel.hidden = NO;
    self.letGoInstructionlabel.hidden = YES;
}

- (void)indicateThresholdReached
{
    [self shouldBeLoading:NO];
    self.pullDownInstructionLabel.hidden = YES;
    self.letGoInstructionlabel.hidden = NO;
}

- (void)startLoading
{
    [self shouldBeLoading:YES];
    self.pullDownInstructionLabel.hidden = YES;
    self.letGoInstructionlabel.hidden = YES;
}

#pragma mark - Private methods

- (void)shouldBeLoading:(BOOL)shouldBeLoading
{
    self.loadingLabel.hidden = !shouldBeLoading;
    (shouldBeLoading ? [self.activityIndicator startAnimating] : [self.activityIndicator stopAnimating]);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
