//
//  RegisterViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *emailRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *fNameRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *lNameRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *genderRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *birthdayRegisterTextField;

-(IBAction)signUpUserPressed:(id)sender;

@end
