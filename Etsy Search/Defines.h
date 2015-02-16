//
//  Defines.h
//  Etsy Search
//
//  Created by Jay Whitsitt on 2/15/15.
//  Copyright (c) 2015 Jay Whitsitt. All rights reserved.
//

#ifndef Etsy_Search_Defines_h
#define Etsy_Search_Defines_h

// Debug only
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#define NSLog(...)
#endif

// Always log this
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// Show in a UIAlertView
#ifdef DEBUG
#define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#define ULog(...)
#endif

#endif
