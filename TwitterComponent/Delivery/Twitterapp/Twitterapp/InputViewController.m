//
//  InputViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.


#import "InputViewController.h"
#import "MasterViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

@synthesize inputField;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"inputSegue"])
    {
       MasterViewController *master=segue.destinationViewController;
               
        master.username=inputField.text;
    }
}

/* 
 Method to clear input text field
 */
 -(IBAction)clearInputField
{
    inputField.text=nil;
}

/* 
 Method to dismiss keyboard
 */
-(IBAction)keyboardDismiss
{
    [inputField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    
}

@end
