//
//  barCodeScanViewController.h
//  BarCodeScan
//
//  Created by Optimus on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"

@interface barCodeScanViewController : UIViewController<ZBarReaderDelegate>
{
    
    UIImageView *resultImage;  //image of the Bar Code
    UITextView *resultText;    //number of the bar code
    
}

-(IBAction)scanCamera;
-(IBAction)exit:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UITextView *resultText;




@end
