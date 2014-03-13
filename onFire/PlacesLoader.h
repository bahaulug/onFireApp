//
//  PlacesLoader.h
//  onFire
//
//  Created by Berkin Sansal on 3.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@class Place;

typedef void (^SuccessHandler)(NSDictionary *responseDict);
typedef void (^ErrorHandler)(NSError *error);

@interface PlacesLoader : NSObject

+ (PlacesLoader *)sharedInstance;

- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;

- (void)loadDetailedInformation:(Place *)location successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;

@end
