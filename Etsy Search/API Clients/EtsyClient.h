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


@interface EtsyResult : NSObject

@property (nonatomic, assign) NSInteger *listingID;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, assign) NSInteger *userID;
@property (nonatomic, assign) NSInteger *categoryID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *resultDescription;
@property (nonatomic, strong) NSDate *endingDate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, assign) NSInteger *quantity;
@property (nonatomic, strong) NSArray *categoryPath;
@property (nonatomic, strong) NSArray *materials;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL *isCustomizable;
@property (nonatomic, assign) BOOL *isDigital;
@property (nonatomic, assign) BOOL *hasVariations;

@end


@interface EtsyClient : NSObject

@property (nonatomic, weak) id<EtsyClientDelegate> delegate;

@property (nonatomic, assign) NSInteger *totalResults;
@property (nonatomic, assign) NSInteger *resultsDownloaded;
@property (nonatomic, strong) NSArray *results; // Array of EtsyResult objects

- (void)getResultsForKeyword:(NSString *)keyword;
- (void)nextPage;

@end
