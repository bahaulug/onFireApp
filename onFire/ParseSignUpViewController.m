//
//  SignUpViewController.m
//  onFire
//
//  Created by Berkin Sansal on 2.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "ParseSignUpViewController.h"

@interface ParseSignUpViewController ()

@end

@implementation ParseSignUpViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.fields = PFSignUpFieldsSignUpButton | PFSignUpFieldsUsernameAndPassword;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
