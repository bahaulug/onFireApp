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
#import "UIImageView+WebCache.h"


@interface MyFiresViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *videoTableView;
@property (nonatomic, retain) NSArray *videoPFObjects;
@property (nonatomic, retain) NSArray *videoPFObjects2;
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
    //Bu queryde include key ekledim yoksa pointerın içindeki data alınmıyor
    
    PFQuery *query = [PFQuery queryWithClassName:@"Video"];
    [query includeKey:@"fromUser"];
    
    //Burada tüm video objeleri videoPfObjects2 adlı nsarraye kaydedildi
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.videoPFObjects2 = objects;
    }];
    
    
    /*PFUser *user = [PFUser currentUser];
    [user valueForKey:@"firstName"];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[user valueForKey:@"firstName"],  [user valueForKey:@"lastName"]];
    cell.videoTitleLabel.text = fullName;*/
    
    
    //Burda tableview hangi rowdaysa ona gelen obje alınıyor ve desc içine atılıyor
    
    PFObject *desc = [self.videoPFObjects2 objectAtIndex:indexPath.row];
    
    PFObject * videoUser = [desc objectForKey:@"fromUser"];
    //NSLog(@"retrieved related Post Author: %@", videoUser);
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[videoUser valueForKey:@"firstName"],  [videoUser valueForKey:@"lastName"]];
    cell.videoTitleLabel.text = fullName;
    
    PFFile *file = [videoUser objectForKey:@"profilePicture"];
    [cell.userImageView setImageWithURL:[NSURL URLWithString:file.url]];
    
    
    NSString *videoDescription = desc[@"VideoDescription"];
    cell.VideoDescriptionLabel.text = videoDescription;
    
    NSDate *date = desc.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    //uncomment to get the time only
    [formatter setDateFormat:@"hh:mm a"];
    [formatter2 setDateFormat:@"dd.MM.yyyy"];
    
    
    //get the date today
    NSString *dateToday = [formatter stringFromDate:date];
    NSString *timeToday = [formatter2 stringFromDate:date];
    
    cell.dateLabel.text = dateToday;
    cell.timeLabel.text = timeToday;

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
