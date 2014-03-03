//
//  Place.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
//#import "Video.h"
//#import "Photo.h"
//#import "Fire.h"
//#import "Location.h"
@class Video;
@class Photo;
@class Fire;
//@class Location;

@interface Place : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString* placeId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) int dislikeCount;
@property (nonatomic, strong) Photo* photo;
@property (nonatomic, strong) Video* video;
//@property (nonatomic, strong) Location* location;
@property (nonatomic, strong) NSMutableArray* fires; // content of the array will be `Fire` class type

- (id)initWithName:(NSString*)name;
// initialize icin diger propertyler ile de method eklenebilir!!

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address;

@end
