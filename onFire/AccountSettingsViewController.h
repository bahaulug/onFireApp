//
//  AccountSettingsViewController.h
//  onFire
//
//  Created by Bengisu Şahin on 11.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSettingsViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>


@property (nonatomic, strong) IBOutlet UIImageView *imgToUpload;

@property (nonatomic, strong) IBOutlet UITextField *emailChangeTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordChangeTextField;

@property (nonatomic, strong) IBOutlet UITextField *fNameChangeTextField;
@property (nonatomic, strong) IBOutlet UITextField *lNameChangeTextField;
@property (nonatomic, strong) IBOutlet UITextField *genderChangeTextField;
@property (nonatomic, strong) IBOutlet UITextField *birthdayChangeTextField;


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UIButton *saveButton;

-(IBAction)savePressed:(id)sender;

@end
