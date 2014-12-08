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

@property (nonatomic, strong) EtsyClient *etsyClient;

@end
