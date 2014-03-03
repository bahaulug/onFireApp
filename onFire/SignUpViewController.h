//
//  SignUpViewController.h
//  onFire
//
//  Created by Berkin Sansal on 4.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *fNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *lNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UITextField *repasswordTextField;

-(IBAction)signUpButtonPressed:(id)sender;

@end
