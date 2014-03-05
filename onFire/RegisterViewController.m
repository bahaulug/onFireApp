//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"

#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize emailRegisterTextField = _emailRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;


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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.emailRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
}


#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.emailRegisterTextField.text;
    user.password = self.passwordRegisterTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was succesful, go to the wall
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView;
            if ([errorString rangeOfString:@"username"].location != NSNotFound && [errorString rangeOfString:@"already taken"].location != NSNotFound) {
                errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This email is already taken" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            }
            else
            {
                errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            }
            [errorAlertView show];
        }
    }];


}

@end
