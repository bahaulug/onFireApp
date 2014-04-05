//
//  ProfileViewController.m
//  onFire
//
//  Created by Berkin Sansal on 26.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    PFUser *user = [PFUser currentUser];
    _friends = [user objectForKey:@"friends"];
    for (int i = 0; i<_friends.count; i++) {
        NSLog(@"%@", _friends[i]);
    }
    PFObject *a = [PFObject objectWithClassName:@"a"];
    [a addObject:user.username forKey:@"aaa"];
    [a addObject:user forKey:@"aaaa"];
    
    [a saveInBackground];
    
    NSMutableArray *aaa = [a objectForKey:@"aaaa"];
    for (int i = 0; i<aaa.count; i++) {
        NSLog(@"%@", aaa[i]);
    }
    
    PFUser * aa = (PFUser*)aaa[0];
    NSLog(aa.username);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.row == 0)
    {
        AccountSettingsViewController *ASVC = [[AccountSettingsViewController alloc] init];
        [[self navigationController] pushViewController:ASVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
        PrivacySettingsViewController *PSVC = [[PrivacySettingsViewController alloc] init];
        [[self navigationController] pushViewController:PSVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        NotificationSettingsViewController *NSVC = [[NotificationSettingsViewController alloc] init];
        [[self navigationController] pushViewController:NSVC animated:YES];
    }
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    //PFUser *friend = (self.friends)[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:_friends[indexPath.row]];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


@end
