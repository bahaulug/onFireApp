//
//  LogInViewController.h
//  onFire
//
//  Created by Berkin Sansal on 4.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

-(IBAction)logInButtonPressed:(id)sender;

@end
