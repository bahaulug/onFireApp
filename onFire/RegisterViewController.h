//
//  RegisterViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegisterViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imgToUpload;
@property (nonatomic, strong) IBOutlet UITextField *emailRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *fNameRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *lNameRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *genderRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *birthdayRegisterTextField;
@property (nonatomic, strong) IBOutlet UIButton *signUpButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

-(IBAction)signUpUserPressed:(id)sender;
-(IBAction)addPicturePressed:(id)sender;

@end
