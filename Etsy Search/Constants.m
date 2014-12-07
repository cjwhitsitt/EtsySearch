//
//  Constants.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - Etsy API
// https://api.etsy.com/v2/listings/active?api_key=&includes=MainImage&keywords=
NSString * const kEtsyAPIDomain = @"https://api.etsy.com";
NSString * const kEtsyAPIEndpointActiveListings = @"v2/listings/active";

NSString * const kEtsyAPIParameterAPIKey = @"api_key";
NSString * const kEtsyAPIParameterIncludes = @"includes";
NSString * const kEtsyAPIParameterKeywords = @"keywords";
NSString * const kEtsyAPIValueMainImage = @"MainImage";

NSString * const kEtsyKeystring = @"z0vntfta51kksj6x13hr007f";
NSString * const kEtsySharedSecret = @"g1sj8few3m";

int const kEtsyResultsPerPage = 25;

@end
