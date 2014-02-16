//
//  Notification.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property (nonatomic, assign) int notificationId;
@property (nonatomic, strong) NSString* message;

@end
