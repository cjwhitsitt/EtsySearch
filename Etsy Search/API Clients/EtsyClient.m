//
//  EtsyClient.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "EtsyClient.h"

#import <AFNetworking/AFNetworking.h>

@implementation EtsyListing

@end

@implementation EtsyClient

- (void)getResultsForKeywords:(NSString *)keywords
{
    // prepare the request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kEtsyAPIDomain, kEtsyAPIEndpointActiveListings];
    NSDictionary *parameters = @{ kEtsyAPIParameterAPIKey : kEtsyKeystring,
                                  kEtsyAPIParameterIncludes : kEtsyAPIValueMainImage,
                                  kEtsyAPIParameterKeywords : keywords };
    
    // success/failure
    void (^successBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Success! responseObject = %@", responseObject);
            
            self.totalListings = [[responseObject objectForKey:@"count"] integerValue];
            if (self.totalListings <= 0) {
                // no results
                return;
            }
            
            [self saveResultsFromDictionary:[responseObject objectForKey:@"results"]];
            
            [self.delegate etsyResultsReturned:self];
        } else {
            // something happened
            [self.delegate errorGettingEtsyResults:self];
        }
    };
    
    void (^failureBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error: %@", error);
        [self.delegate errorGettingEtsyResults:self];
    };
    
    // make the request
    [manager GET:urlString parameters:parameters success:successBlock failure:failureBlock];
}

- (void)nextPage
{
    
}

#pragma mark - private methods

- (void)saveResultsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *mutableListings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *listing in dictionary) {
        EtsyListing *etsyListing = [[EtsyListing alloc] init];
        etsyListing.listingID = [[listing objectForKey:@"listing_id"] integerValue];
        etsyListing.state = [listing objectForKey:@"state"];
        etsyListing.userID = [[listing objectForKey:@"user_id"] integerValue];
        etsyListing.categoryID = [[listing objectForKey:@"category_id"] integerValue];
        etsyListing.title = [listing objectForKey:@"title"];
        etsyListing.resultDescription = [listing objectForKey:@"description"];
        
        NSInteger unixEndingDate = [[listing objectForKey:@"ending_tsz"] integerValue];
        etsyListing.endingDate = [NSDate dateWithTimeIntervalSince1970:unixEndingDate];
        
        etsyListing.price = [listing objectForKey:@"price"];
        etsyListing.currency = [listing objectForKey:@"currency_code"];
        etsyListing.quantity = [[listing objectForKey:@"price"] integerValue];
        etsyListing.categoryPath = [listing objectForKey:@"category_path"];
        etsyListing.materials = [listing objectForKey:@"materials"];
        etsyListing.url = [listing objectForKey:@"url"];
        etsyListing.isCustomizable = [[listing objectForKey:@"is_customizable"] boolValue];
        etsyListing.isDigital = [[listing objectForKey:@"is_digital"] boolValue];
        etsyListing.hasVariations = [[listing objectForKey:@"has_variations"] boolValue];
        
        [mutableListings addObject:etsyListing];
    }
    
    _listings = mutableListings;
}

@end
