//
//  NotificationSettingsViewController.h
//  onFire
//
//  Created by Bengisu Şahin on 23.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationSettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *likeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *commentSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *requestSwitch;

@end
