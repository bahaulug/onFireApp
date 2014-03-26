//
//  AccountSettingsViewController.m
//  onFire
//
//  Created by Berkin Sansal on 26.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "AccountSettingsViewController.h"

@interface AccountSettingsViewController ()

@end

@implementation AccountSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
