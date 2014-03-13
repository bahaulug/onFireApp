//
//  MainViewController.m
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlacesLoader.h"
#import "Place.h"
#import "PlaceAnnotation.h"
#import <Parse/Parse.h>

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const klatitudeKeypath = @"geometry.location.lat";
NSString * const klongitudeKeypath = @"geometry.location.lng";

@interface MainViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *locations;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *lastLocation = [locations lastObject];
    CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    if (accuracy < 100.0) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
        MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
        [_mapView setRegion:region animated:YES];
        
        // more code here
        [[PlacesLoader sharedInstance] loadPOIsForLocation:[locations lastObject] radius:1000 successHandler:^(NSDictionary *response) {
            NSLog(@"Response: %@", response);
            // more code here
            if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
                id places = [response objectForKey:@"results"];
                NSMutableArray *temp = [NSMutableArray array];
                
                if ([places isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *resultsDict in places) {
                        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:klatitudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:klongitudeKeypath] floatValue]];
                        Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:kReferenceKey] name:[resultsDict objectForKey:kNameKey] address:[resultsDict objectForKey:kAddressKey]];
                        
                        [temp addObject:currentPlace];
                        
                        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
                        [_mapView addAnnotation:annotation];
                    }
                }
                _locations = [temp copy];
                NSLog(@"Locations: %@", _locations);
            }
        } errorHandler:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        [manager stopUpdatingLocation];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)xTabButtonPressed:(id)sender
{
    [PFUser logOut];
    [self performSegueWithIdentifier:@"Logout" sender:self];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setLocations:_locations];
        [[segue destinationViewController] setUserLocation:[_mapView userLocation]];
    }
}

@end
