//
//  FlipsideViewController.m
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Place.h"
#import "MarkerView.h"
#import "PlacesLoader.h"

NSString * const kPhoneKey = @"formatted_phone_number";
NSString * const kWebsiteKey = @"website";

const int kInfoViewTag = 1001;

@interface FlipsideViewController () <MarkerViewDelegate>

@property (nonatomic, strong) AugmentedRealityController *arController;
@property (nonatomic, strong) NSMutableArray *geoLocations;

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if(!_arController)
    {
        _arController = [[ AugmentedRealityController alloc] initWithView:[self view] parentViewController:self withDelgate:self];
    }
    
    [_arController setMinimumScaleFactor:0.5];
    [_arController setScaleViewsBasedOnDistance:YES];
    [_arController setRotateViewsBasedOnPerspective:YES];
    [_arController setDebugMode:NO];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self geoLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) generateGeoLocations {
    
    [self setGeoLocations:[NSMutableArray arrayWithCapacity:[_locations count]]];
    
    for(Place *place in _locations) {
        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:[place location] locationTitle:[place name]];
        
        [coordinate calibrateUsingOrigin:[_userLocation location]];
        
        //more code gelcek
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate: coordinate delegate: self];
        [coordinate setDisplayView:markerView];
        
        [_arController addCoordinate:coordinate];
        [_geoLocations addObject:coordinate];
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

-(void) didUpdateHeading:(CLHeading *)newHeading{
    
}

-(void) didUpdateLocation:(CLLocation *)newLocation{
    
}

-(void) didUpdateOrientation:(UIDeviceOrientation)orientation{
    
}

- (void) didTapMarker:(ARGeoCoordinate *)coordinate{
    
}

- (NSMutableArray *) geoLocations{
    if (!_geoLocations) {
        [self generateGeoLocations];
    }
    return _geoLocations;
}

- (void)didTouchMarkerView:(MarkerView *)markerView {
    ARGeoCoordinate *tappedCoordinate = [markerView coordinate];
    CLLocation *location = [tappedCoordinate geoLocation];
    
    int index = [_locations indexOfObjectPassingTest:^(id obj, NSUInteger index, BOOL *stop) {
        return [[(Place *)obj location] isEqual:location];
    }];
    
    if (index != NSNotFound) {
        Place *tappedPlace = [_locations objectAtIndex:index];
        [[PlacesLoader sharedInstance] loadDetailedInformation:tappedPlace successHandler:^(NSDictionary *response) {
            NSLog(@"Responses: %@", response);
            NSDictionary *resultDict = [response objectForKey:@"result"];
            [tappedPlace setDescription:[resultDict objectForKey:kPhoneKey]];
            [tappedPlace setPlaceId:[resultDict objectForKey:kWebsiteKey]];
            [self showInfoViewForPlace:tappedPlace];
        }errorHandler:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (void)showInfoViewForPlace: (Place *)place {
    CGRect frame = [[self view] frame];
    UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(50.0f, 50.0f, frame.size.width - 100.0f, frame.size.height - 100.0f)];
    [infoView setCenter:[[self view] center]];
    [infoView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    [infoView setText:[place infoText]];
    [infoView setTag:kInfoViewTag];
    [infoView setEditable:NO];
    
    [[self view] addSubview:infoView];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *infoView = [[self view] viewWithTag:kInfoViewTag];
    
    [infoView removeFromSuperview];
}

@end
