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

@property (nonatomic, strong) UITextField *activeField;
//@property (nonatomic, assign) CGRect initialFrame;
@property (nonatomic, assign) CGPoint initialOffset;
@property (nonatomic, assign) CGSize kbSize;

@end

@implementation RegisterViewController

@synthesize emailRegisterTextField = _emailRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;
@synthesize fNameRegisterTextField = _fNameRegisterTextField, lNameRegisterTextField = _lNameRegisterTextField;
@synthesize genderRegisterTextField = _genderRegisterTextField, birthdayRegisterTextField = _birthdayRegisterTextField;
@synthesize signUpButton = _signUpButton;
@synthesize imgToUpload = _imgToUpload;
@synthesize scrollView, activeField, initialOffset, kbSize;
//@synthesize initialFrame;


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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delegate = self;
    [scrollView addGestureRecognizer:tapGesture];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    initialOffset = scrollView.contentOffset;
    //initialFrame = scrollView.frame;
    kbSize = CGSizeMake(0.0, 0.0);
    
    _emailRegisterTextField.delegate = self;
    _passwordRegisterTextField.delegate = self;
    _fNameRegisterTextField.delegate = self;
    _lNameRegisterTextField.delegate = self;
    _genderRegisterTextField.delegate = self;
    _birthdayRegisterTextField.delegate = self;
    [self registerForKeyboardNotifications];
    
    // Do any additional setup after loading the view from its nib.
    self.emailRegisterTextField.text = @"aaa@aaa.com";
    self.passwordRegisterTextField.text = @"aaa";
    self.fNameRegisterTextField.text = @"ber";
    self.lNameRegisterTextField.text = @"san";
    self.genderRegisterTextField.text = @"male";
    self.birthdayRegisterTextField.text = @"20141010";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.emailRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
}

-(IBAction)addPicturePressed:(id)sender
{
    //Open a UIImagePickerController to select the picture
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentModalViewController:imgPicker animated:YES];
}

#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    
    [picker dismissModalViewControllerAnimated:YES];
    
    //Place the image in the imageview
    self.imgToUpload.image = img;
    //self.imgToUpload.image.imageOrientation = i
}

#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
    //Disable the sign up button until we are ready
    self.signUpButton.enabled = NO;
    
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [loadingSpinner setCenter:CGPointMake(scrollView.frame.size.width/20.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.scrollView addSubview:loadingSpinner];
    
    //Upload a new picture
    NSData *pictureData = UIImageJPEGRepresentation(self.imgToUpload.image, 0.8f);
    //NSData *pictureData = UIImagePNGRepresentation(self.imgToUpload.image);
    
    PFFile *file = [PFFile fileWithData:pictureData];
    
            [PFUser logOut];
            PFUser *user = [PFUser user];
            user.username = self.emailRegisterTextField.text;
            user.password = self.passwordRegisterTextField.text;
            user.email =self.emailRegisterTextField.text;
            [user setObject:self.fNameRegisterTextField.text forKey:@"firstName"];
            [user setObject:self.lNameRegisterTextField.text forKey:@"lastName"];
            [user setObject:self.genderRegisterTextField.text forKey:@"gender"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyyMMdd"];
            NSDate *date = [dateFormat dateFromString:self.birthdayRegisterTextField.text];
            [user setObject:date forKey:@"birthday"];
            [user setObject:file forKey:@"profilePicture"];
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    //The registration was succesful, go to the wall
                    [self performSegueWithIdentifier:@"SignupSuccessful" sender:self];
                    
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
                
                [loadingSpinner stopAnimating];
                [loadingSpinner removeFromSuperview];
                self.signUpButton.enabled = YES;
            }];
        
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //CGRect bkgndRect = activeField.frame;
    //bkgndRect.size.height += kbSize.height;
    //[activeField setFrame:bkgndRect];
    [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //[activeField setFrame:initialFrame];
    [scrollView setContentOffset:initialOffset animated:YES];
    kbSize = CGSizeMake(0.0, 0.0);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if (kbSize.width != 0.0 && kbSize.height != 0.0)
    {
        //CGRect bkgndRect = activeField.frame;
        //bkgndRect.size.height += kbSize.height;
        //[activeField setFrame:bkgndRect];
        [scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailRegisterTextField) {
        [textField resignFirstResponder];
        [_passwordRegisterTextField becomeFirstResponder];
    } else if (textField == _passwordRegisterTextField) {
        [textField resignFirstResponder];
        [_fNameRegisterTextField becomeFirstResponder];
    } else if (textField == _fNameRegisterTextField) {
        [textField resignFirstResponder];
        [_lNameRegisterTextField becomeFirstResponder];
    } else if (textField == _lNameRegisterTextField) {
        [textField resignFirstResponder];
        [_birthdayRegisterTextField becomeFirstResponder];
    } else if (textField == _birthdayRegisterTextField) {
        [textField resignFirstResponder];
        [_genderRegisterTextField becomeFirstResponder];
    } else if (textField == _genderRegisterTextField) {
        [self signUpUserPressed:nil];
    }
    return YES;
}

// method to hide keyboard when user taps on a scrollview
-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

@end
