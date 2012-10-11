//
//  FLDidLoginViewController.h
//  FacebookLogin
//
//  Created by Optimus Information on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FLDidLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *userInfo;
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
- (IBAction)fbLogout:(UIButton *)sender;

@end
