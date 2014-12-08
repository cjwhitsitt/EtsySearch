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

@end


@interface EtsyListing : NSObject

@property (nonatomic) NSInteger listingID;
@property (nonatomic, strong) NSString *state;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger categoryID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *resultDescription;
@property (nonatomic, strong) NSDate *endingDate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, strong) NSArray *categoryPath;
@property (nonatomic, strong) NSArray *materials;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) BOOL isCustomizable;
@property (nonatomic) BOOL isDigital;
@property (nonatomic) BOOL hasVariations;

@end


@interface EtsyClient : NSObject

@property (nonatomic, weak) id<EtsyClientDelegate> delegate;

@property (nonatomic) NSInteger totalListings;
@property (nonatomic) NSInteger listingsDownloaded;
@property (nonatomic, strong) NSArray *listings; // Array of EtsyListing objects

- (void)getResultsForKeywords:(NSString *)keywords;
- (void)nextPage;

@end
