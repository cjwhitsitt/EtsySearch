//
//  EtsyClient.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EtsyClient;

@protocol EtsyClientDelegate <NSObject>

- (void)etsyResultsReturned:(EtsyClient *)etsyClient;
- (void)errorGettingEtsyResults:(EtsyClient *)etsyClient;
- (void)noEtsyResults:(EtsyClient *)etsyClient;

@end


@interface EtsyListing : NSObject

@property (nonatomic) NSInteger listingID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *resultDescription;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIImage *mainImage;

@end


@interface EtsyClient : NSObject

@property (nonatomic, weak) id<EtsyClientDelegate> delegate;

@property (nonatomic) NSInteger totalListings;
@property (nonatomic) NSInteger listingsDownloaded;
@property (nonatomic, strong) NSArray *listings; // Array of EtsyListing objects
@property (nonatomic, readonly) NSString *keywords;

- (void)getResultsForKeywords:(NSString *)keywords;
- (void)nextPage;

@end
