//
//  Admin.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "User.h"
#import "Owner.h"
#import "Place.h"
#import "Member.h"
#import "Fire.h"


@interface Admin : User

@property (nonatomic, strong) NSMutableArray* approveList; // content of the array will be `Owner` class type

- (BOOL)approveOwner:(Owner*)owner withPlace:(Place*)place;
- (BOOL)deleteOwner:(Owner*)owner;
- (BOOL)deleteFire:(Fire*)fire;
- (BOOL)postWarning:(NSString*)warning;
- (BOOL)deleteMember:(Member*)member;

@end
