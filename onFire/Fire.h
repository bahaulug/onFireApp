//
//  Fire.h
//  onFire
//
//  Created by Berkin Sansal on 16.01.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fire : NSObject

@property (nonatomic, assign) int fireId;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* description;

@end
