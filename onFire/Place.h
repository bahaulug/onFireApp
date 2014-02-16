//
//  Place.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"
#import "Photo.h"
#import "Fire.h"
#import "Location.h"

@interface Place : NSObject

@property (nonatomic, strong) NSString* placeId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, assign) int likeCount;
@property (nonatomic, assign) int dislikeCount;
@property (nonatomic, strong) Photo* photo;
@property (nonatomic, strong) Video* video;
@property (nonatomic, strong) Location* location;
@property (nonatomic, strong) NSMutableArray* fires; // content of the array will be `Fire` class type

@end
