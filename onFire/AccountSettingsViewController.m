//
//  AccountSettingsViewController.m
//  onFire
//
//  Created by Bengisu Şahin on 11.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "AccountSettingsViewController.h"

#import <Parse/Parse.h>

@interface AccountSettingsViewController ()

@property (nonatomic, strong) UITextField *activeField;
//@property (nonatomic, assign) CGRect initialFrame;
@property (nonatomic, assign) CGPoint initialOffset;
@property (nonatomic, assign) CGSize kbSize;

@end

@implementation AccountSettingsViewController

@synthesize fNameChangeTextField = _fNameChangeTextField ;
@synthesize lNameChangeTextField = _lNameChangeTextField;
@synthesize genderChangeTextField = _genderChangeTextField;
@synthesize birthdayChangeTextField = _birthdayChangeTextField;

@synthesize scrollView, activeField, initialOffset, kbSize;
@synthesize saveButton = _saveButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delegate = self;
    [scrollView addGestureRecognizer:tapGesture];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    initialOffset = scrollView.contentOffset;
    //initialFrame = scrollView.frame;
    kbSize = CGSizeMake(0.0, 0.0);
    
    _fNameChangeTextField.delegate = self;
    _lNameChangeTextField.delegate = self;
    _genderChangeTextField.delegate = self;
    _birthdayChangeTextField.delegate = self;
    
    self.fNameChangeTextField.text = [[PFUser currentUser] objectForKey:@"firstName" ];
    self.lNameChangeTextField.text = [[PFUser currentUser] objectForKey:@"lastName" ];
    self.genderChangeTextField.text = [[PFUser currentUser] objectForKey:@"gender" ];
    
    NSDate *birthday = [[PFUser currentUser] objectForKey:@"birthday" ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.birthdayChangeTextField setText:[dateFormatter stringFromDate:birthday]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)savePressed:(id)sender
{
    NSLog(@"asd");
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [loadingSpinner setCenter:CGPointMake(scrollView.frame.size.width/20.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.scrollView addSubview:loadingSpinner];
    
    
    [[PFUser currentUser] setObject:self.fNameChangeTextField.text forKey:@"firstName"];
    [[PFUser currentUser] setObject:self.lNameChangeTextField.text forKey:@"lastName"];
    [[PFUser currentUser] setObject:self.genderChangeTextField.text forKey:@"gender"];
    [[PFUser currentUser] saveInBackground];
    
    
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
    if (textField == _fNameChangeTextField) {
        [textField resignFirstResponder];
        [_lNameChangeTextField becomeFirstResponder];
    } else if (textField == _lNameChangeTextField) {
        [textField resignFirstResponder];
        [_birthdayChangeTextField becomeFirstResponder];
    } else if (textField == _birthdayChangeTextField) {
        [textField resignFirstResponder];
        [_genderChangeTextField becomeFirstResponder];
    } else if (textField == _genderChangeTextField){
        [self savePressed:nil];
    }
    return YES;
}

// method to hide keyboard when user taps on a scrollview
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}


@end
