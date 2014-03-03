//
//  PlaceAnnotation.m
//  onFire
//
//  Created by Berkin Sansal on 3.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation ()
@property (nonatomic, strong) Place *place;
@end

@implementation PlaceAnnotation

- (id)initWithPlace:(Place *)place
{
    if ((self = [super init]))
    {
        _place = place;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return [_place location].coordinate;
}

- (NSString *)title
{
    return [_place name];
}

@end
