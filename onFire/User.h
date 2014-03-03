//
//  User.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Notification.h"
@class Notification;

@interface User : NSObject

@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* gender;
@property (nonatomic, assign) int birthDay;
@property (nonatomic, assign) int birthMonth;
@property (nonatomic, assign) int birthYear;
@property (nonatomic, strong) NSMutableArray* notifications; // content of the array will be `Notification` class type

- (id)initWithFName:(NSString*)fName lName:(NSString*)lName email:(NSString*)email password:(NSString*)password gender:(NSString*)gender bDay:(int)bDay bMonth:(int)bMonth bYear:(int)bYear;

@end
