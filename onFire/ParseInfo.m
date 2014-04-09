//
//  ParseInfo.m
//  onFire
//
//  Created by Berkin Sansal on 09/04/14.
//  Copyright (c) 2014 Berkin Sansal. All rights reserved.
//

#import "ParseInfo.h"

@implementation ParseInfo

-(void)parseInfo {
    
    //////////////////////
    // To create an object in database
    /*
    PFObject *obj = [PFObject objectWithClassName:@"ClassName"];
    [obj setObject:@"value1" forKey:@"key1"];
    [obj setObject:@"value2" forKey:@"key2"];
    [obj setObject:@"value3" forKey:@"key3"];
        
    [obj saveInBackground];
    */
    
    ///////////////////////
    // To find an user from database
    /*
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:_friends[i]];
    PFUser *user2 = (PFUser *)[query getFirstObject];
    */
     
    //////////////////////
    // To find an object from database
    /*
     PFQuery *query = [PFQuery queryWithClassName:@"ClassName"];
     [query whereKey:@"columnName" equalTo:@"value"];
     [query getFirstObjectInBackgroundWithBlock:^(PFObject * obj, NSError *error) {
     if (!error) {
     
     // read object for key
     [obj objectForKey:@"columnName"];
     
     // add object for key which is array in Parse
     [obj addObject:obj2 forKey:@"arrayColumnName"];
     
     // update object for key
     [obj setObject:obj3 forKey:@"columnName"];
     
     // save changes
     [obj saveInBackground];
     
     } else {
     // Did not find any UserStats for the current user
     NSLog(@"Error: %@", error);
     }
     }];
     */
    
}

@end
