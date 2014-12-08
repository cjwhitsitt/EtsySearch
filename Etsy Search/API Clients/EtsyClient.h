//
//  EtsyClient.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EtsyClientDelegate <NSObject>

- (void)resultsReturned;
- (void)errorGettingResults;

@end

@interface EtsyClient : NSObject

- (void)getResultsForKeyword:(NSString *)keyword;
- (void)nextPage;

@end