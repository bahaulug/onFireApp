//
//  Place.m
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "Place.h"
#import "Video.h"
#import "Photo.h"
#import "Fire.h"
#import "Location.h"

@implementation Place

@synthesize placeId;
//@synthesize name;
@synthesize description;
@synthesize likeCount;
@synthesize dislikeCount;
@synthesize photo;
@synthesize video;
//@synthesize  location;
@synthesize fires;

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address
{
    if ((self = [super init])) {
        _location = location;
        _reference = reference;
        _address = address;
        _name = name;
    }
    return self;
}

@end
