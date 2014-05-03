//
//  FriendsViewController.m
//  onFire
//
//  Created by Baha Ulug on 29.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "FriendsViewController.h"
#import <Parse/Parse.h>
#import "FriendsCell.h"
#import "UIImageView+WebCache.h"

@interface FriendsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;
@property (nonatomic, retain) NSArray *friends;
@end

@implementation FriendsViewController

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
    
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.friends = objects;
        [self.friendsTableView reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
    if(!cell)
        cell = [[FriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCell"];
    PFUser *user = [PFUser currentUser];
    [user valueForKey:@"firstName"];
    
    
    PFObject *object = [self.friends objectAtIndex:indexPath.row];
    [object fetchIfNeeded];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[object valueForKey:@"firstName"],  [object valueForKey:@"lastName"]];
    cell.friendNameLabel.text = fullName;
    PFFile *file = [object objectForKey:@"profilePicture"];
    [cell.friendImageView setImageWithURL:[NSURL URLWithString:file.url]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
