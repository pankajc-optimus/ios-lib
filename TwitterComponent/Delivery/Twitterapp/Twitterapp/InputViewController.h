//
//  InputViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.


/**InputViewController class to show page which asks user to enter username to view tweets.Presents view named 'Input'.
 */

#import <UIKit/UIKit.h>

@interface InputViewController : UIViewController
{
    IBOutlet UITextField *inputField;

}
@property (strong,retain) UITextField *inputField;

/**Text Field is cleared when show button is pressed
 */
-(IBAction)clearInputField;

/**Keyboard is dismissed when tapped on the screen
 */
-(IBAction)keyboardDismiss;
@end
