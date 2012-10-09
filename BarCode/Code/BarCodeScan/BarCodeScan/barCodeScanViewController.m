//
//  barCodeScanViewController.m
//  BarCodeScan
//
//  Created by Optimus on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

-(IBAction)scanCamera;
{
   
    ZBarReaderViewController *barCodeReader=[[ZBarReaderViewController alloc]init];
    barCodeReader.readerDelegate=self;
    
    
    [self presentModalViewController:barCodeReader animated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
   
    id<NSFastEnumeration> result=[info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol=nil;
    for(symbol in result)
    {
        break;
    }
    resultText.text=symbol.data;
   
    resultImage.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissModalViewControllerAnimated:YES];
    
    
}



-(IBAction)exit:(id)sender
{
    exit(0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    resultText.text=nil;
    resultImage.image=nil;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return YES;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        resultText.frame = CGRectMake(320, 50, 218, 35);
        resultImage.frame=CGRectMake(20, 20, 240, 150);
      
    }
    else {
        resultText.frame=CGRectMake(52, 244, 218, 35);
        resultImage.frame=CGRectMake(20, 35, 280, 166);
    }
}

@end
