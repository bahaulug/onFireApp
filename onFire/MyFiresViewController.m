//
//  MyFiresViewController.m
//  onFire
//
//  Created by Baha Ulug on 13.04.2014.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "MyFiresViewController.h"
#import "MyFiresVideoCell.h"
#import <Parse/Parse.h>

@interface MyFiresViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *videoTableView;
@property (nonatomic, retain) NSArray *videoPFObjects;
@property (nonatomic, retain) MyFiresVideoCell *lastCellDisplayed;
@property (nonatomic, retain) NSArray *usersID;
@end

@implementation MyFiresViewController

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
    PFQuery *query = [PFQuery queryWithClassName:@"Video"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.videoPFObjects = objects;
        [self.videoTableView reloadData];
        [self playVideoInCell];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoPFObjects.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MyFiresVideoCell";
    MyFiresVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if(!cell){
        cell = [[MyFiresVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    PFUser *user = [PFUser currentUser];
    [user valueForKey:@"firstName"];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[user valueForKey:@"firstName"],  [user valueForKey:@"lastName"]];
    cell.videoTitleLabel.text = fullName;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *video = [self.videoPFObjects objectAtIndex:indexPath.row];
    ((MyFiresVideoCell*)cell).video = video;
}

- (void)playVideoInCell{
    NSArray *cellIndexPaths = [self.videoTableView indexPathsForVisibleRows];
    CGFloat centerY =  self.view.bounds.size.height/2;
    CGFloat min = self.view.frame.size.height;
    MyFiresVideoCell *optimalCell;
    NSIndexPath *path;
    NSIndexPath *optimalPath;
    for(path in cellIndexPaths){
        MyFiresVideoCell *cell = (MyFiresVideoCell*)[self.videoTableView cellForRowAtIndexPath:path];
        CGPoint point = [cell convertPoint:CGPointMake(0,0) toView:self.view];
        if(min > abs(point.y-centerY)){
            min = point.y - centerY;
            optimalCell = cell;
            optimalPath = path;
        }
    }
    for(path in cellIndexPaths){
        MyFiresVideoCell *cell = (MyFiresVideoCell*)[self.videoTableView cellForRowAtIndexPath:path];
        if(optimalCell == cell){
            [cell playVideo];
        }
        else{
            [cell stopVideo];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self playVideoInCell];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
