//
//  FlipsideViewController.h
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ARKit.h"

@class CameraViewController;

@protocol CameraViewControllerDelegate
- (void)cameraViewControllerDidFinish:(CameraViewController *)controller;
@end

@interface CameraViewController : UIViewController <ARLocationDelegate, ARDelegate, ARMarkerDelegate>

@property (weak, nonatomic) id <CameraViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) MKUserLocation *userLocation;

- (IBAction)done:(id)sender;

@end
