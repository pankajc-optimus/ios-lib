//
//  FLDidLoginViewController.m
//  FacebookLogin
//
//  Created by Optimus Information on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//


/**
 * fbLogout method to logout user and close fbsession.
 */

#import "FLDidLoginViewController.h"
#import "FLAppDelegate.h"
#import "FLViewController.h"
#import "FLFriendsViewController.h"
#import "FLFacebookAPI.h"

@interface FLDidLoginViewController ()

@end

@implementation FLDidLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set permission for publish once user session is open.
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI setActiveSessionPermission:^(NSError *error, NSString *result) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error setting permission" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.userInfo.text = result;
        }
    }];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release properties.
    
    [self setUserInfo:nil];
    [self setUserNameLabel:nil];
    [self setUserProfileImage:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show user basic information (JSON), profile image and name.
    if (FBSession.activeSession.isOpen)
    {
        [self populateUserDetails];
    }
}
- (void)sessionStateChanged:(NSNotification*)notification
{
    [self populateUserDetails];
}

/*
 Method to fetch user basic details including profile picture.
 This calls 'getLoggedInUserInfo' method of FLFacebookAPI method.
 */
- (void)populateUserDetails
{
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getLoggedInUserInfo:^(NSError *error, NSDictionary<FBGraphUser> *user) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            NSString *userJSONInfo = [[NSString alloc]initWithFormat:@"%@", user ];
            self.userInfo.text = userJSONInfo;
            
            self.userNameLabel.text = user.name;
            self.userProfileImage.profileID = user.id;
        }
    }];
}

/** Method to logout user form the application and navigate to login page
 * @param UIButton sender.
 * Destroy facebook session
 */
- (IBAction)fbLogout:(UIButton *)sender
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
 Method to navigate to the friends page containing options for Wall Post, Upload Photo, fetch friends etc.
 */
- (IBAction)goToFriendsPage:(id)sender
{
    FLFriendsViewController *friendsPage = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendsPage"];
    
    [self presentModalViewController:friendsPage animated:NO];
}

/*
 Method to get authentication token.
 */
- (IBAction)getTokenAction:(UIButton *)sender
{
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getAuthenticationToken:^(NSError *error, id authenticationToken)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         }
         else
         {
             self.userInfo.text = [[NSString alloc] initWithFormat:@"%@", authenticationToken];
         }
     }];
}

/*
 Method to get token expiry date.
 */
- (IBAction)getTokenExpiryAction:(UIButton *)sender
{
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getExpiryDate:^(NSError *error, NSDate *expiryDate)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         }
         else
         {
             self.userInfo.text = [[NSString alloc] initWithFormat:@"%@", expiryDate];
         }
     }];
}
@end
