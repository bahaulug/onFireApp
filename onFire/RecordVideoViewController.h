//
//  RecordVideoViewController.h
//  onFire
//
//  Created by Baha Ulug on 25.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Parse/Parse.h>

@interface RecordVideoViewController: UIViewController{
    
    PFObject *object;
    
    BOOL complete;
    BOOL comment;
}

-(IBAction)recordAndPlay:(id)sender;
-(void)addVideo;
-(IBAction)addDescription:(id)sender;
-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSDictionary* settings;
@property (nonatomic,strong) IBOutlet UITextField *commentView;


@end
