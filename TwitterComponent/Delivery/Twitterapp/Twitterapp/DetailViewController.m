//
//  DetailViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.


#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize detailItem;

/*
 Method to configure the page.
 */
- (void)configureView
{
    if (self.detailItem) {
        
        //Data received from MasterViewController through segue stored in tweet
        NSDictionary *tweet = self.detailItem;
        //Name of the tweeter to store in name object
        NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        
        //Tweet to store in text object
        NSString *text = [tweet objectForKey:@"text"];
        
        //Multi lines
        tweetLabel.numberOfLines = 0;
        
        //To set name of the tweeter 
        nameLabel.text = name;
        
        //To set tweet
        tweetLabel.text = text;
        
    
        NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        if(data==nil)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Check network connectivity for image" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        //To set image of the tweeter
        profileImage.image = [UIImage imageWithData:data];
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  YES;
}

@end
