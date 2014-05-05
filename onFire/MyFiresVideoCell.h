//
//  MyFiresVideoCell.h
//  onFire
//
//  Created by Baha Ulug on 29.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface MyFiresVideoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *videoTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *VideoDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *videoImageView;
@property (nonatomic, retain) PFObject *video;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (void)playVideo;
- (void)stopVideo;

@end
