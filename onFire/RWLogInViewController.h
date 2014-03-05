//
//  LoginViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RWLogInViewController : UIViewController


@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;


-(IBAction)logInPressed:(id)sender;

@end
