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

- (void)playVideo;
- (void)stopVideo;

@end
