//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RWLogInViewController.h"
#import "RegisterViewController.h"

#import <Parse/Parse.h>

@implementation RWLogInViewController

@synthesize emailTextField = _emailTextField, passwordTextField = _passwordTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PFUser *user = [PFUser currentUser];
    // Tester id
    // Email: admin
    // Password: admin
    self.emailTextField.text = user.username;
    self.passwordTextField.text = user.password;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.emailTextField = nil;
    self.passwordTextField = nil;
}


#pragma mark IB Actions

//Login button pressed
-(IBAction)logInPressed:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
             //[self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
