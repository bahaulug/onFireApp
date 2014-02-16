//
//  Like.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface Like : NSObject

@property (nonatomic, assign) int likeId;
@property (nonatomic, strong) Member* member; // member who liked
@property (nonatomic, strong) NSDate* date;

@end
