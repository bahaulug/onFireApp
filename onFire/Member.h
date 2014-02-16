//
//  Member.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "User.h"
#import "Place.h"
#import "Photo.h"
#import "Fire.h"

@interface Member : User

@property (nonatomic, assign) int flag;

- (BOOL)addFriend:(Member*)member;
- (BOOL)deleteFriend:(Member*)member;
- (BOOL)fireUp:(Place*)place;
- (BOOL)deleteFire:(Fire*)fire;
- (BOOL)addFavoritePlace:(Place*)place;
- (BOOL)editPhoto:(Photo*)photo;

@end
