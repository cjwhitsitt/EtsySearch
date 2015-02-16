//
//  LoadingTableViewCell.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/9/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingTableViewCell : UITableViewCell

- (void)reset;
/** This method changes the cell to show that the table view is loading more data */
- (void)startLoading;
/** This method changes the cell temporarily to tell the user to let go of the scroll view to load more data */
- (void)indicateThresholdReached;

@end
