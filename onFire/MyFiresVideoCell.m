//
//  MyFiresVideoCell.m
//  onFire
//
//  Created by Baha Ulug on 29.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "MyFiresVideoCell.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MyFiresVideoCell()
@property (nonatomic, retain) MPMoviePlayerController *videoController;
@property (nonatomic, retain) MBProgressHUD *hud;
@end


@implementation MyFiresVideoCell
@synthesize VideoDescriptionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showProgressHud:(BOOL)show{
    if(!show){
        [_hud show:NO];
        [_hud removeFromSuperview];
        return ;
    }
    if(!_hud){
        _hud = [[MBProgressHUD alloc] initWithView:self.contentView];
        [self.contentView addSubview:_hud];
    }
    [_hud show:YES];
}


- (void)setVideo:(PFObject *)video{
    [self showProgressHud:NO];
    _video = video;
    
//    [self.videoController stop];
    self.videoController.contentURL = nil;
    if(video==nil)
        return;
    
    
    
    
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    [self showProgressHud:YES];
    [video fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [self showProgressHud:NO];
        PFFile *videoFile = [video objectForKey:@"Video"];
        
        MPMoviePlayerController *moviePlayer;
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:videoFile.url]];

        moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        moviePlayer.movieControlMode = MPMovieControlModeDefault;
        moviePlayer.controlStyle = MPMovieControlStyleNone;
        //moviePlayer.backgroundColor = [UIColor blackColor];
        
        moviePlayer.view.frame = self.videoImageView.frame;
        [self.contentView addSubview:moviePlayer.view];
        self.videoController = moviePlayer;
//                [self.videoController play];
    }];

    if(self.videoController == nil){
        
    
       
    }

    

}

- (void)playVideo{
    if(self.videoController.playbackState == MPMoviePlaybackStateStopped)
        [self.videoController play];
}

- (void)stopVideo{
    if(self.videoController.playbackState != MPMoviePlaybackStateStopped)
        [self.videoController stop];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
