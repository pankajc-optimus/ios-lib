//
//  barCodeScanViewController.h
//  BarCodeScan
//
//  Created by Optimus on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

/* This application contains ZBarSDK library libzbar.a which supports armv7 architecture. So, do make sure that you have correct architecture settings in Build Settings. 
 */


#import <UIKit/UIKit.h>
#import "ZBarSDK/Headers/ZBarSDK/ZBarSDK.h"


@interface barCodeScanViewController : UIViewController<ZBarReaderDelegate>
{
    UIImageView *resultImage;  //image of the Bar Code
    UITextView *resultText;    //number of the bar code
    
}
/** Checks whether iPad or iPhone
 *
 * If Device is connected and iPad, returns YES, else returns NO.
 */
-(BOOL)isPad;

/** Returns an action which presents camera and autoscans the bar code.
 *
 *Method is called when Scan button is pressed.
 */
-(IBAction)scanUsingCamera;

/** Returns exit action when Exit button is pressed.
 */
-(IBAction)exit:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *resultImage;
@property (strong, nonatomic) IBOutlet UITextView *resultText;

@end
