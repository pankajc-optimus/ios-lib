//
//  TwitterappViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.

#import "TwitterappViewController.h"

@interface TwitterappViewController ()

@end

@implementation TwitterappViewController

-(IBAction)tweet:(id)sender {
    
    //Initialising object of class TWTweetComposeViewController which contains the tweet module.
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    //Present tweet module view controller
    [self presentViewController:twitter animated:YES completion:nil];
    
    //Block which is executed depending upon action done (cancel or send)
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        
        //Dismissing tweet module 
        [self dismissModalViewControllerAnimated:YES];
        
        //Alert to remind log out
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Don't forget to log out. Go to Settings->Twitter" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        [alert show];
    };
    
}

//Terminating application
-(IBAction)exit:(id)sender
{
    exit(0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Have something to tweet?" message:@"Make sure that you are logged in. Go to settings->Twitter" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    
    [alert show];
   
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
   
}

@end
