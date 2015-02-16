//
//  ResultDetailViewController.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 2/15/15.
//  Copyright (c) 2015 Jay Whitsitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtsyClient.h"

@interface ResultDetailViewController : UIViewController

- (ResultDetailViewController *)initWithEtsyListing:(EtsyListing *)etsyListing;

@end
