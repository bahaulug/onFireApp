//
//  UserProfileViewController.h
//  onFire
//
//  Created by Berkin Sansal on 09/04/14.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController

@property (nonatomic, strong) NSString *currentUsername;

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIImageView *userPic;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *about;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

-(void)setUsername:(NSString*)username;

@end
