//
//  FLAppDelegate.h
//  FacebookLogin
//
//  Created by Optimus Information on 10/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBSession;

@interface FLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *fbsession;

@end
