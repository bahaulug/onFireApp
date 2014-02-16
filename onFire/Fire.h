//
//  Fire.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Member.h"
//#import "Video.h"
//#import "Like.h"
//#import "Comment.h"
//#import "Place.h"
//#import "Location.h"
@class Member;
@class Video;
@class Like;
@class Comment;
@class Place;
@class Location;

@interface Fire : NSObject

@property (nonatomic, assign) int fireId;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) Video* video;
@property (nonatomic, strong) Location* location;
@property (nonatomic, strong) NSMutableArray* likes; // content of the array will be `Like` class type
@property (nonatomic, strong) NSMutableArray* comments; // content of the array will be `Comment` class type
@property (nonatomic, strong) Member* member;
@property (nonatomic, strong) Place* place;

@end
