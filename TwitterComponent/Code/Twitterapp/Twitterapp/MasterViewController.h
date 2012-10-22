//
//  MasterViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.


/**This class shows all the tweets of entered username. Presents Table view named'Tweets'.
 */
#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface MasterViewController : UITableViewController{
    NSArray *tweets;
}

/**Fetch the tweets by requesting URL
 *@param NSString nameString
 */
- (void)fetchTweets:(NSString *)nameString;
@property (strong,nonatomic) NSString *username;
@end
