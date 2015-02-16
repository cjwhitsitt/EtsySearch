//
//  ResultsTableViewController.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EtsyClient.h"

@interface ResultsTableViewController : UITableViewController <EtsyClientDelegate>

/** Set the EtsyClient object used for searching when this view controller is created. This way, when the view controller is alive, the EtsyClient object will be as well in order to allow for the next page functionality to work.
 */
@property (nonatomic, strong) EtsyClient *etsyClient;

@end
