//
//  InitialViewController.m
//  onFire
//
//  Created by Yağız Oyun on 07.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "InitialViewController.h"
#import <Parse/Parse.h>

@interface InitialViewController ()

@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"Loggedin" sender:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
