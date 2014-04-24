//
//  ProfileViewController.m
//  onFire
//
//  Created by Berkin Sansal on 26.03.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserProfileViewController.h"
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

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFUser *user = [PFUser currentUser];
    
    _name.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"firstName"], [user objectForKey:@"lastName"]];
    PFFile *imageFile = [user objectForKey:@"profilePicture"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            _userPic.image = [UIImage imageWithData:data];
        }
    }];
    _about.text = user.username;
    [_segmentedControl addTarget:self
                          action:@selector(changeSegmented:)
                forControlEvents:UIControlEventValueChanged];

    
    _friends = [user objectForKey:@"friends"];
    /*
     for (int i = 0; i<_friends.count-1; i++) {
     PFQuery *query = [PFUser query];
     [query whereKey:@"username" equalTo:_friends[i]];
     PFUser *user2 = (PFUser *)[query getFirstObject];
     for (int j = i+1; j<_friends.count; j++) {
     PFQuery *query = [PFUser query];
     [query whereKey:@"username" equalTo:_friends[j]];
     PFUser *user3 = (PFUser *)[query getFirstObject];
     PFObject *a = [PFObject objectWithClassName:@"Friendship"];
     [a setObject:user2 forKey:@"from"];
     [a setObject:user3 forKey:@"to"];
     [a setObject:@"1" forKey:@"status"];
     
     [a saveInBackground];
     }
     }
     */
    
    /*
     PFQuery *query = [PFQuery queryWithClassName:@"a"];
     [query whereKey:@"username" equalTo:aa.username];
     [query getFirstObjectInBackgroundWithBlock:^(PFObject * ab, NSError *error) {
     if (!error) {
     [ab addObject:user.username forKey:@"aaa"];
     [ab addObject:user forKey:@"aaaa"];
     
     [ab saveInBackground];
     } else {
     // Did not find any UserStats for the current user
     NSLog(@"Error: %@", error);
     }
     }];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeSegmented:(id)sender{
    [_tableView reloadData];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_segmentedControl selectedSegmentIndex] == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UserProfileViewController *UPVC = [[UserProfileViewController alloc] init];
        [UPVC setUsername:cell.detailTextLabel.text];
        [[self navigationController] pushViewController:UPVC animated:YES];
    }
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
    
    if ([_segmentedControl selectedSegmentIndex] == 1) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:_friends[indexPath.row]];
        PFUser *user = (PFUser *)[query getFirstObject];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"firstName"], [user objectForKey:@"lastName"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:_friends[indexPath.row]];
    }
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
