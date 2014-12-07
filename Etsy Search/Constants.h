//
//  Constants.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - Etsy API
extern NSString * const kEtsyAPIDomain;
extern NSString * const kEtsyAPIEndpointActiveListings;

extern NSString * const kEtsyAPIParameterAPIKey;
extern NSString * const kEtsyAPIParameterIncludes;
extern NSString * const kEtsyAPIParameterKeywords;
extern NSString * const kEtsyAPIValueMainImage;

extern NSString * const kEtsyKeystring;
extern NSString * const kEtsySharedSecret;

extern int const kEtsyResultsPerPage;

@end
