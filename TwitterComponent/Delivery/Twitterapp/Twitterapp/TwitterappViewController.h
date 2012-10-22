//
//  TwitterappViewController.h
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.

/** This application needs two extra libraries. 
 1.Twitter.framework which is added from linrary folder only. 
 2.JSON library
 
 In this application,login is to be done in settings of the iOS device.iOS 5+ devices does not support present OAuth library.
 */
 

/** This class shows the page which has the option to tweet and show tweets.Presents view named 'Home'.
 */
#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface TwitterappViewController : UIViewController

/**Tweet module is opened when Tweet button is pressed.
 */
-(IBAction)tweet:(id)sender;

/** Application gets terminated when Exit button is pressed
 */
-(IBAction)exit:(id)sender;

@end
