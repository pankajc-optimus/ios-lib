//
//  FLFriendsViewController.h
//  FBLogin
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FLFriendsViewController : UIViewController<FBFriendPickerDelegate, UITextFieldDelegate>
- (IBAction)selectFriends:(id)sender;
- (IBAction)wallPostAction:(UIButton *)sender;
- (IBAction)uploadPhotoAction:(UIButton *)sender;
- (IBAction)deletePhotoAction:(UIButton *)sender;
- (IBAction)getFriendsFQL:(UIButton *)sender;
- (IBAction)getFriendsPostsAction:(UIButton *)sender;
- (IBAction)getMyPostsAction:(UIButton *)sender;
- (IBAction)searchFriendAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *textViewResultOutlet;
- (IBAction)goBackAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *deletePostIDField;
- (IBAction)backgroundTouchedAction;
- (IBAction)generalFQLQueryAction;
- (IBAction)likePostAction:(UIButton *)sender;

@end
