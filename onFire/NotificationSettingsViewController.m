//
//  NotificationSettingsViewController.m
//  onFire
//
//  Created by Bengisu Şahin on 23.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "NotificationSettingsViewController.h"

@interface NotificationSettingsViewController ()

@end

@implementation NotificationSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)likelikeSwitchValueChanged:(id)sender
{
    if (self.likeSwitch.isOn) {
        NSLog(@"1");
    } else {
        NSLog(@"2");
    }
    
}
- (IBAction)commentSwitchValueChanged:(id)sender {
    if (self.commentSwitch.isOn) {
        NSLog(@"1");
    } else {
        NSLog(@"2");
    }
}
- (IBAction)requestswitchValueChanged:(id)sender {
    if (self.requestSwitch.isOn) {
        NSLog(@"1");
    } else {
        NSLog(@"2");
    }
}



@end
