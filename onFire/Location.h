//
//  Location.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, assign) int latitude;
@property (nonatomic, assign) int longitude;

- (id)initWithLatitude:(int)latitude longitude:(int)longitude;
- (void)getCurrentLocation;

@end
