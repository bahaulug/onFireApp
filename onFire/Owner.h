//
//  Owner.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "User.h"
//#import "Place.h"
//#import "Video.h"
//#import "Photo.h"
@class Place;
@class Video;
@class Photo;

@interface Owner : User

@property (nonatomic, assign) int flag;
@property (nonatomic, strong) NSMutableArray* placeList; // content of the array will be `Place` class type

- (BOOL)requestPlace:(Place*)place;
- (BOOL)removePlace:(Place*)place;
- (BOOL)editVideo:(Video*)video;
- (BOOL)editPhoto:(Photo*)photo;
- (BOOL)editDescription:(NSString*)description;

@end
