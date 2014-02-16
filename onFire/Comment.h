//
//  Comment.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface Comment : NSObject

@property (nonatomic, assign) int commentId;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) Member* member; // member who commented

@end
