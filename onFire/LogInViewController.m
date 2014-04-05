//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LogInViewController.h"
#import "RegisterViewController.h"

#import <Parse/Parse.h>

@implementation LogInViewController

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
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    PFUser *user = [PFUser currentUser];
    // Tester id
    // Email: admin@admin.com
    // Password: admin
    self.emailTextField.text = @"admin@admin.com";
    self.passwordTextField.text = @"admin";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    self.emailTextField = nil;
    self.passwordTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [self logInPressed:nil];
    }
    return YES;
}

#pragma mark IB Actions

//Login button pressed
-(IBAction)logInPressed:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
             [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
