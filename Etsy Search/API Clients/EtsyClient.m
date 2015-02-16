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
            self.totalListings = [[responseObject objectForKey:@"count"] integerValue];
            if (self.totalListings <= 0) {
                // no results
                [self.delegate noEtsyResults:self];
            } else {
                // save the results
                [self saveResultsFromDictionary:[responseObject objectForKey:@"results"]];
                [self.delegate etsyResultsReturned:self];
            }
            _keywords = keywords;
            
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
    // prepare the request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kEtsyAPIDomain, kEtsyAPIEndpointActiveListings];
    NSDictionary *parameters = @{ kEtsyAPIParameterAPIKey : kEtsyKeystring,
                                  kEtsyAPIParameterIncludes : kEtsyAPIValueMainImage,
                                  kEtsyAPIParameterKeywords : self.keywords,
                                  kEtsyAPIParameterOffset : @([self.listings count]) };
    
    // success/failure
    void (^successBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.totalListings = [[responseObject objectForKey:@"count"] integerValue];
            if (self.totalListings <= 0) {
                // no results
                [self.delegate noEtsyResults:self];
            } else {
                // save the results
                [self appendResultsFromDictionary:[responseObject objectForKey:@"results"]];
                [self.delegate etsyResultsReturned:self];
            }
            
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

#pragma mark - private methods

- (void)saveResultsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *mutableListings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *listing in dictionary) {
        EtsyListing *etsyListing = [[EtsyListing alloc] init];
        etsyListing.listingID = [[listing objectForKey:@"listing_id"] integerValue];
        etsyListing.title = [listing objectForKey:@"title"];
        etsyListing.resultDescription = [listing objectForKey:@"description"];
        etsyListing.price = [listing objectForKey:@"price"];
        etsyListing.url = [listing objectForKey:@"url"];
        
        NSDictionary *imageDictionary = [listing objectForKey:@"MainImage"];
        NSURL *imageURL = [NSURL URLWithString:[imageDictionary objectForKey:@"url_75x75"]];
        etsyListing.mainImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        
        [mutableListings addObject:etsyListing];
    }
    
    _listings = mutableListings;
}

- (void)appendResultsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *mutableListings = [self.listings mutableCopy];
    
    for (NSDictionary *listing in dictionary) {
        EtsyListing *etsyListing = [[EtsyListing alloc] init];
        etsyListing.listingID = [[listing objectForKey:@"listing_id"] integerValue];
        etsyListing.title = [listing objectForKey:@"title"];
        etsyListing.resultDescription = [listing objectForKey:@"description"];
        etsyListing.price = [listing objectForKey:@"price"];
        etsyListing.url = [listing objectForKey:@"url"];
        
        NSDictionary *imageDictionary = [listing objectForKey:@"MainImage"];
        NSURL *imageURL = [NSURL URLWithString:[imageDictionary objectForKey:@"url_75x75"]];
        etsyListing.mainImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        
        [mutableListings addObject:etsyListing];
    }
    
    _listings = mutableListings;
}

@end
