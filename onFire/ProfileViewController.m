//
//  ProfileViewController.m
//  onFire
//
//  Created by Baha Ulug on 4.05.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize nameLabel;
@synthesize aboutLabel;
@synthesize imageLabel;

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
    PFUser *user =[PFUser currentUser];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[user valueForKey:@"firstName"],  [user valueForKey:@"lastName"]];
    PFFile *image = [user objectForKey:@"profilePicture"];
    [imageLabel setImageWithURL:[NSURL URLWithString:image.url]];
    
    [nameLabel setText:fullName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
