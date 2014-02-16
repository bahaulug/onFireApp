//
//  Member.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "User.h"
//#import "Place.h"
//#import "Photo.h"
//#import "Fire.h"
//#import "Location.h"
@class Place;
@class Photo;
@class Fire;
@class Location;

@interface Member : User

@property (nonatomic, assign) int flag;
@property (nonatomic, strong) Location* currentLoc; // current location
@property (nonatomic, strong) Photo* photo; // profile picture
@property (nonatomic, strong) NSMutableArray* friends; // content of the array will be `Member` class type
@property (nonatomic, strong) NSMutableArray* favoritePlaces; // content of the array will be `Place` class type
@property (nonatomic, strong) NSMutableArray* fires; // content of the array will be `Fire` class type

- (BOOL)addFriend:(Member*)member;
- (BOOL)deleteFriend:(Member*)member;
- (BOOL)fireUp:(Place*)place;
- (BOOL)deleteFire:(Fire*)fire;
- (BOOL)addFavoritePlace:(Place*)place;
- (BOOL)editPhoto:(Photo*)photo;

@end
