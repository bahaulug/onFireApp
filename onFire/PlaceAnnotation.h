//
//  PlaceAnnotation.h
//  onFire
//
//  Created by Berkin Sansal on 3.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject <MKAnnotation>

- (id)initWithPlace:(Place *)place;
- (CLLocationCoordinate2D)coordinate;
- (NSString *)title;
- (NSString *)subtitle;

@end
