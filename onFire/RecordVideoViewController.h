//
//  RecordVideoViewController.h
//  onFire
//
//  Created by Baha Ulug on 25.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface RecordVideoViewController: UIViewController

-(IBAction)recordAndPlay:(id)sender;
-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;
@property (nonatomic, strong) NSDictionary* settings;

@end
