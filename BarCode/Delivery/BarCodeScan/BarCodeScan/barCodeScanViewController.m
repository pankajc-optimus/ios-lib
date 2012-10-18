//
//  barCodeScanViewController.m
//  BarCodeScan
//
//  Created by Optimus on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "barCodeScanViewController.h"

@interface barCodeScanViewController ()

@end

@implementation barCodeScanViewController
@synthesize resultImage;
@synthesize resultText;

/*
 Method to present camera feed scanner  which is called when user taps scan button
 */

-(IBAction)scanUsingCamera;
{
    
    ZBarReaderViewController *barCodeReader=[[ZBarReaderViewController alloc]init];
    barCodeReader.readerDelegate=self;
    
    //to open camera and autoscan the bar code
    [self presentModalViewController:barCodeReader animated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // to store results
    id<NSFastEnumeration> result=[info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol=nil;
    for(symbol in result)
    {
        break;
    }
    //to set reultText
    resultText.text=symbol.data;
    
    //to set resultImage
    resultImage.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:YES];
    
    
}

/* 
 Method to terminate application
*/ 
-(IBAction)exit:(id)sender
{
    exit(0);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    resultText.text=nil;
    resultImage.image=nil;

	
}

- (void)viewDidUnload
{
    [self setResultText:nil];
    [self setResultImage:nil];

    [super viewDidUnload];
    
  }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

/*
 Method to change orientation
 
*/ 
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    if([self isPad])
    {
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
            
            resultText.frame = CGRectMake(504, 120, 478, 51);
            resultImage.frame=CGRectMake(20, 20, 400, 250);
            
            
        }
        else {
            resultText.frame=CGRectMake(124,504, 478, 51);
            resultImage.frame=CGRectMake(124, 159, 521, 328);
            
        }

    
    }
    else 
    {
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
            resultText.frame = CGRectMake(320, 50, 208, 48);
            resultImage.frame=CGRectMake(20, 20, 240, 150);
            
            
        }
        else {
            
            resultText.frame=CGRectMake(29, 240, 208, 48);
            resultImage.frame=CGRectMake(29, 10, 262, 177);
            
        }

        
    }
    
 
}

/*
 Check user device
 */ 
- (BOOL) isPad{ 
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}




@end
