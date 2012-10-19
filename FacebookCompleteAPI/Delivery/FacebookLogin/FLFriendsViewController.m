//
//  FLFriendsViewController.m
//  FBLogin
//
//  Created by Optimus Information on 16/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "FLFriendsViewController.h"
#import "FLFacebookAPI.h"

@interface FLFriendsViewController ()

@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
- (void)fillTextBoxAndDismiss:(NSString *)text;

@end

@implementation FLFriendsViewController

@synthesize friendPickerController = _friendPickerController;

- (void)viewDidLoad
{
	self.deletePostIDField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectFriends:(id)sender
{
    if (self.friendPickerController == nil)
    {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    // iOS 5.0+ apps should use [UIViewController presentViewController:animated:completion:]
    // rather than this deprecated method, but we want our samples to run on iOS 4.x as well.
    [self presentModalViewController:self.friendPickerController animated:YES];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender
{
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection)
    {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender
{
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text
{
    self.textViewResultOutlet.text = text;
    
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [self setTextViewResultOutlet:nil];
    [self setDeletePostIDField:nil];
    [super viewDidUnload];
}

/** Method to post on Facebook wall
 * Calls "postMessageOnWall" method of FLFacebookAPI which takes NSDictionary
 * argument of what data is to be posted on wall.
 * For the sake of this example we are passing a params dictionary which contains
 * description, image, link, name and caption.
 */
- (IBAction)wallPostAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"This is a test description to test FB wall share via custom iPhone app",@"description",
                                   @"http://www.gearsandgeardrives.com/images/jindal_logo.jpg",@"picture",
                                   @"www.google.com/invites/username", @"link",
                                   @"Google",@"name",
                                   @"www.google.com",@"caption",
                                   nil];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI postMessageOnWall:params completionHandler:^(NSError *error, id data) {
        if (error)
        {
            // TODO show login error
            NSLog(@"Error while fetching friends");
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", data];
        }
    }];
}

/*
 Action to upload photo.
 */
- (IBAction)uploadPhotoAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    // Download a sample photo
    NSURL *url = [NSURL URLWithString:@"http://www.gearsandgeardrives.com/images/jindal_logo.jpg"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI uploadPhoto:data completionHandler:^(NSError *error, id data) {
        if (error)
        {
            // TODO show login error
            NSLog(@"Error while fetching friends");
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", data];
        }
    }];
    
}

/*
 Method to delete posts/likes/images.
 */
- (IBAction)deletePhotoAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    id deletePostID = self.deletePostIDField.text;
    
    if([deletePostID length] > 0)
    {
        FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
        [facebookAPI deletePost:deletePostID];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter post id which is to be deleted" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        
        [errorAlert show];
    }    
}

/*
 Action to get friends corresponding to logged in user in FLFacebookAPI.
 */
- (IBAction)getFriendsFQL:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getFriendList:25 completionHandler:^(NSError *error, NSDictionary *friendsList)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         }
         else
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", friendsList];
             });
         }
     }];
    
}

/*
 Action to get friends posts corresponding to logged in user in FLFacebookAPI.
 */
- (IBAction)getFriendsPostsAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getFriendsPosts :^(NSError *error, NSDictionary *postsList)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         }
         else
         {
             self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", postsList];
         }
     }];
}

/*
 Action to get posts corresponding to logged in user in FLFacebookAPI.
 */
- (IBAction)getMyPostsAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI getMyPosts:50 completionHandler:^(NSError *error, NSDictionary *postsList) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", postsList];
        }
    }];
}

/*
 Action to trigger search friend call in FLFacebookAPI.
 */
- (IBAction)searchFriendAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    [facebookAPI searchFriendByName:@"Amit" completionHandler:^(NSError *error, NSDictionary *searchedFriendList) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", searchedFriendList];
        }
    }];
}

// FBSample logic
// Report any results.  Invoked once for each request we make.
- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error
{
    NSLog(@"request completed");
    
    if(error)
    {
        NSLog(@"error occured while posting to wall%@", error);
    }
    else
    {
        NSLog(@"Post Successful %@", result);
    }
}

/*
 Method to go back to the home page
 */
- (IBAction)goBackAction:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:NO];
}
/*
 Method to close keyboard when background is touched
 */
- (IBAction)backgroundTouchedAction
{
    [self closeOnScreenKeyboard];
}

/*
 Method to execute general/ any FQL query on the basis of permissions.
 */
- (IBAction)generalFQLQueryAction
{
    FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
    
    // Query to search friend.
    NSString *query = @"SELECT uid, username, first_name, last_name FROM user WHERE uid IN"
    @"(SELECT uid2 FROM friend WHERE uid1 = me()) AND first_name = 'Pankaj'";
    
    [facebookAPI getFQLResult:query completionHandler:^(NSError *error, NSDictionary *searchedFriendList) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error fetching friends" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else
        {
            self.textViewResultOutlet.text = [[NSString alloc] initWithFormat:@"%@", searchedFriendList];
        }
    }];
}

/*
    Method to like a post/feed/image
*/
- (IBAction)likePostAction:(UIButton *)sender
{
    [self closeOnScreenKeyboard];
    
    id likePostID = self.deletePostIDField.text;
    
    if([likePostID length] > 0)
    {
        FLFacebookAPI *facebookAPI = [[FLFacebookAPI alloc]init];
        [facebookAPI likePost:likePostID];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter post id which is to be liked" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        
        [errorAlert show];
    }
}

/*
 Method to close onscreen keyboard
 */
-(void)closeOnScreenKeyboard
{
    [self.deletePostIDField resignFirstResponder];
}
@end
