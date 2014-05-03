//
//  RecordVideoViewController.m
//  onFire
//
//  Created by Baha Ulug on 25.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "RecordVideoViewController.h"
#import "MBProgressHUD.h"
@interface RecordVideoViewController ()
- (IBAction)RecordAndPlay:(id)sender;

@end

@implementation RecordVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showProgressHud:(BOOL)show{
    static MBProgressHUD *hud = nil;
    if(!show){
        [hud show:NO];
        [hud removeFromSuperview];
        return ;
    }
    if(!hud)
        hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud show:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RecordAndPlay:(id)sender {
    
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

//For Starting to camera and recording video

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate {
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.videoMaximumDuration = 10.0f;
    cameraUI.allowsEditing = YES;
    cameraUI.videoQuality = UIImagePickerControllerQualityTypeMedium;
    cameraUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

//Saving video to the media gallery

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:NO];
    _videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@", _videoURL);
    
    //Saving to parse
    
    //Create video
    PFObject *newVideo = [PFObject objectWithClassName:@"Video"];
    
    //Take video as NSData
    
    NSData * videoData = [NSData dataWithContentsOfURL:_videoURL];
    
    PFFile *videoFile = [PFFile fileWithName:@"video.mov" data:videoData];
    newVideo[@"Video"] = videoFile;
    [newVideo setObject:[PFUser currentUser] forKey:@"fromUser"];//One to Many RelationShip
    
    
    [self showProgressHud:YES];
    [newVideo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *errorupload){
        [self showProgressHud:NO];
        if(errorupload){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry:(" message:@"Your Video Could not be Uploaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OnFire" message:@"Now Your Video is OnFire"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    
    // Handle a movie capture for saving gallery
    
    /*if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }*/
}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


/*- (void)imagePickerController:(UIImagePickerController *)picker      didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@", videoURL);
    
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (self.moviePath))
    {
        UISaveVideoAtPathToSavedPhotosAlbum (self.moviePath, nil, nil, nil);
    }
    
    [self shouldUploadVideo];
    [self doneButtonAction];
}*/

/*- (void)shouldUploadVideo {
    
    //Capturamos el NSUserdefault para grabar el evento
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadstring = [defaults objectForKey:@"Video"];
    NSLog(@"Working at first line");
    
    
    
    NSData *videoData = [NSData dataWithContentsOfURL:self.videoURL];
    NSLog(@"Working at second line");
    
    
    PFFile *videoFile = [PFFile fileWithData:videoData];
    NSLog(@"Working at third line");
    
    [self.videoFile saveInBackground];
    NSLog(@"Working at last line");
    
}

- (void)doneButtonAction {
    // Make sure there was no errors creating the image files
    if (!self.videoFile) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't save your photo"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Dismiss",nil];
        [alert show];
        return;
    }
    
    // Create a Photo object
    PFObject *video = [PFObject objectWithClassName:kPAPPhotoClassKey];
    [video setObject:[PFUser currentUser] forKey:kPAPPhotoUserKey];
    [video setObject:self.videoFile forKey:@"Video"];
    
    // Request a background execution task to allow us to finish uploading
    // the photo even if the app is sent to the background
    self.photoPostBackgroundTaskId = [[UIApplication sharedApplication]   beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
    
    // Save the Photo PFObject
    [video saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Photo uploaded");
            
            // Add the photo to the local cache
            [[PAPCache sharedCache] setAttributesForPhoto:video likers:[NSArray array] commenters:[NSArray array] likedByCurrentUser:NO];
            
            // Send a notification. The main timeline will refresh itself when caught
            [[NSNotificationCenter defaultCenter] postNotificationName:PAPTabBarControllerDidFinishEditingPhotoNotification object:video];
        } else {
            NSLog(@"Photo failed to save: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your photo"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss",nil];
            [alert show];
        }
        
        // If we are currently in the background, suspend the app, otherwise
        // cancel request for background processing.
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
    
    // Dismiss this screen
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    
}*/
@end
