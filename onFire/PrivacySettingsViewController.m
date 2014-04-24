//
//  PrivacySettingsViewController.m
//  onFire
//
//  Created by Bengisu Şahin on 16.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "PrivacySettingsViewController.h"

@interface PrivacySettingsViewController ()

@property (nonatomic) NSUInteger profile;
@property (nonatomic) NSUInteger fire;

@end

@implementation PrivacySettingsViewController

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

    self.profile = 1;
    self.fire = 2;
}

#pragma mark -
#pragma mark === UITableViewDataSource ===
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section)
    {
        case 0:
            if (row == self.profile)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
            
        case 1:
            if (row == self.fire)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section)
    {
        case 0:
            self.profile = row;
            
            break;
            
        case 1:
            self.fire = row;
            
            break;
    }
    
    [self.tableView reloadData];
}


@end
