//
//  FLViewController.m
//  FacebookLogin
//
//  Created by Optimus Information on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

/** Facebook Login steps.
 1. Download the latest SDK from developer.facebook.com
 2. Add facebook.framework by selecting project, Build Phases. Select "Link Binary  with Libraries". Click + button and add facebook framework from the location where it is installed.
 3. Add class FBSession to the AppDelegate header file.
 4. Include "FBProfilePictureView class" in didFinishLaunchingWithOptions.
 5. Add "[FBSession.activeSession handleDidBecomeActive];" to applicationDidBecomeActive.
 6. Add "[FBSession.activeSession close];" to applicationWillTerminate.
 7. Add "- (BOOL)application:(UIApplication *)application
 openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
 annotation:(id)annotation" method to the AppDelegate.
 8. Call method "openNewFbSession:(NSArray *)permissions array" to open session with facebook. 
 9.  fbLogout (defined on FLDidLoginViewController)method to logout user and close fbsession.
 */

#import "FLViewController.h"

#import "FLDidLoginViewController.h"
#import "FLAppDelegate.h"

@interface FLViewController ()

@end

@implementation FLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** Allow user to login.
 *
 * @param UIButton sender
 * Sets permissions array to the openNewFbSession
 */
- (IBAction)fbLogin:(UIButton *)sender
{
    NSArray *permissions = [NSArray arrayWithObjects:@"email", @"user_birthday", nil];
    [self openNewFbSession:permissions];

}

/** Gets called from openNewFbSession to determine the state of session.
 *
 * @param FBSession object 
 * @param FBSessionState object
 * @param NSError object
 * Sets permissions array to the openNewFbSession
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"session open");
            FLDidLoginViewController *didLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];

            [self presentViewController:didLogin animated:NO completion:nil];
            
            
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            NSLog(@"session destroyed");
            break;
        default:
            break;
    }
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/** Opens facebook session.
 *
 * @param Permissions array for the facebook session.
 * Opens the facebook session and call sessionStateChanged method.
 */
- (void)openNewFbSession:(NSArray *) permissions
{
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}


@end
