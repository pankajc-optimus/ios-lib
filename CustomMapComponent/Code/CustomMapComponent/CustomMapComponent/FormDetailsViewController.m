//
//  FormDetailsViewController.m
//  CustomMapComponent
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "FormDetailsViewController.h"

@interface FormDetailsViewController ()

@end

@implementation FormDetailsViewController

@synthesize locationInformationDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    NSLog(@"locationInformationDictionary %@", locationInformationDictionary);
    self.navigationItem.title = @"Location Details";
    
    // Call method to display information into textfields.
    [self displayFields];
    
}

/*
 Method call to display information into textfields.
 */
-(void)displayFields
{
    if(locationInformationDictionary.count >0)
    {
        NSString *touchedLocation = [locationInformationDictionary valueForKey:@"touchedLocation"];
        NSString *country = [locationInformationDictionary valueForKey:@"country"];
        NSString *zipCode = [locationInformationDictionary valueForKey:@"postalCode"];
        
        UITextField *locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.view.frame.size.width-20.0f, 30.0f)];
        [locationTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [locationTextField setText:touchedLocation];
        locationTextField.enabled = NO;
        
        UITextField *countryTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 45.0f, self.view.frame.size.width-20.0f, 30.0f)];
        [countryTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [countryTextField setText:country];
        countryTextField.enabled = NO;
       
        UITextField *zipCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 80.0f, self.view.frame.size.width-20.0f, 30.0f)];
        [zipCodeTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [zipCodeTextField setText:zipCode];
        zipCodeTextField.enabled = NO;
        
        [self.view addSubview:locationTextField];
        [self.view addSubview:countryTextField];
        [self.view addSubview:zipCodeTextField];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
