//
//  DetailViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.


/** This class is to show the details of a particular tweet selected.Presents view named'Tweet'.
 */

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController 
{
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tweetLabel;
}

/** To configure the view. Sets the name of the tweeter, image of the tweeter and tweet.
 */
- (void)configureView;

@property (strong, nonatomic) id detailItem;
@end
