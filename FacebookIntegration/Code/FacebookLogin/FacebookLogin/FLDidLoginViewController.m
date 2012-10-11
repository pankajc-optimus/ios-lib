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

@interface FLDidLoginViewController ()

@end

@implementation FLDidLoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}
- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = user.id;
                 
                 NSString *userInfo = @"";
                 
                 // Example: typed access (name)
                 // - no special permissions required
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Name: %@\n\n",
                              user.name]];
                 
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Birthday: %@\n\n",
                              user.birthday]];
                 
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Location: %@\n\n",
                              [user.location objectForKey:@"name"]]];
                 
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Locale: %@\n\n",
                              [user objectForKey:@"locale"]]];
                 
                 NSLog(@"%@", userInfo);
                 
                 self.userInfo.text = userInfo;
                 
                 if ([user objectForKey:@"languages"]) {
                     NSArray *languages = [user objectForKey:@"languages"];
                     NSMutableArray *languageNames = [[NSMutableArray alloc] init];
                     for (int i = 0; i < [languages count]; i++) {
                         [languageNames addObject:[[languages
                                                    objectAtIndex:i]
                                                   objectForKey:@"name"]];
                     }
                     userInfo = [userInfo
                                 stringByAppendingString:
                                 [NSString stringWithFormat:@"Languages: %@\n\n",
                                  languageNames]];                     

                     
                 }
                 
                 
             }
         }];
    }
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
@end
