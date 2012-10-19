//
//  FLFacebookAPI.m
//  FBLogin
//
//  Created by Optimus Information on 18/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "FLFacebookAPI.h"

@implementation FLFacebookAPI

/*
 Method to set permissions
 */
-(void)setActiveSessionPermission:(FBApiCompletionHandler)completionHandler
{
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
    
    // Set permissions for publish once user fb session is open.
    [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:NO completionHandler:^(FBSession *session,
                                                                                                                                                        FBSessionState state,
                                                                                                                                                        NSError *error) {
        if(error)
        {
            completionHandler(error, nil);
        }
        else
        {
            completionHandler(nil, @"Permissions Set successfully");
        }
    }];
}

/*
 Method to fetch logged in user information.
 */
-(void)getLoggedInUserInfo: (FBApiCompletionHandler)completionHandler
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error)
         {
             if (!error)
             {
                 
                 completionHandler(nil, user);
             }
             else
             {
                 completionHandler(error, nil);
             }
         }];
    }
}

/*
 Method to post status/message on wall.
 */
-(void) postMessageOnWall:(NSMutableDictionary *)parameterDictionary completionHandler:(FBApiCompletionHandler)completionHandler
{
    // Create the connection object
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // Create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error)
    {
        // output the results of the request
        if(error)
        {
            completionHandler(error, nil);
        }
        else
        {
            completionHandler(nil, result);
        }
        [self requestCompleted:connection forFbID:@"me" result:result error:error];
    };
    
    FBRequest *request=[[FBRequest alloc] initWithSession:FBSession.activeSession graphPath:@"me/feed" parameters:parameterDictionary HTTPMethod:@"POST"];
    
    [newConnection addRequest:request completionHandler:handler];
    
    [newConnection start];
}

/*
 Method to upload photo on facebook, irrespective of photo source.
 This method requires NSData representation of photo.
 */
-(void) uploadPhoto:(NSData *)photoData completionHandler:(FBApiCompletionHandler)completionHandler
{
    UIImage *img  = [[UIImage alloc] initWithData:photoData];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   img, @"picture",
                                   nil];
    
    // create the connection object
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error)
    {
        // output the results of the request
        [self requestCompleted:connection forFbID:@"me" result:result error:error];
        if(error)
        {
            completionHandler(error, nil);
        }
        else
        {
            completionHandler(nil, result);
        }
        
    };
    
    FBRequest *request=[[FBRequest alloc] initWithSession:FBSession.activeSession graphPath:@"me/photos" parameters:params HTTPMethod:@"POST"];
    
    [newConnection addRequest:request completionHandler:handler];
    
    [newConnection start];
}

/*
 Method to return friend list corresponding to the login credentials.
 */
-(void)getFriendList:(int)countOfFriends completionHandler:(FBApiCompletionHandler)completionHandler
{
    NSString *query =
    @"SELECT uid, name, pic_square FROM user WHERE uid IN "
    @"(SELECT uid2 FROM friend WHERE uid1 = me() LIMIT";
    
    query = [[query stringByAppendingFormat:@" %d", countOfFriends] stringByAppendingString:@")"];
    
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             completionHandler(error, nil);
         } else
         {
             NSLog(@"Result: %@", result);
             completionHandler(nil, result);
         }
     }];
    
}

/*
 Method to return post done by friends.
 */
-(void)getFriendsPosts: (FBApiCompletionHandler)completionHandler
{
    NSString *query = @"SELECT post_id, message, description, comments FROM stream WHERE filter_key = 'others'";
    
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             completionHandler(error, nil);
         } else
         {
             NSLog(@"Result: %@", result);
             completionHandler(nil, result);
         }
     }];
}

/*
 Method to return posts related to the login credentials.
 */
-(void)getMyPosts:(int)countOfPosts completionHandler:(FBApiCompletionHandler)completionHandler
{
    NSString *query = @"SELECT post_id, message, description, comments FROM stream WHERE source_id = me() Limit ";
    query = [query stringByAppendingFormat:@"%d", countOfPosts];
    
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             completionHandler(error, nil);
         } else
         {
             NSLog(@"Result: %@", result);
             completionHandler(nil, result);
         }
     }];
}

/*
 Method to search friend from friend list on the basis of name.
 */
-(void)searchFriendByName:(NSString *)toBeSearchedFriendName completionHandler:(FBApiCompletionHandler)completionHandler
{
    // Query to search friend.
    NSString *query = @"SELECT uid, username, first_name, last_name FROM user WHERE uid IN"
    @"(SELECT uid2 FROM friend WHERE uid1 = me()) AND first_name = ";
    
    query = [[[query stringByAppendingString:@"'"] stringByAppendingString:toBeSearchedFriendName] stringByAppendingString:@"'"];
    
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             completionHandler(error, nil);
         } else
         {
             NSLog(@"Result: %@", result);
             completionHandler(nil, result);
         }
     }];
}

-(void)getFQLResult:(NSString *)FQLQuery completionHandler:(FBApiCompletionHandler)completionHandler
{
    // Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:FQLQuery, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
             completionHandler(error, nil);
         } else
         {
             NSLog(@"Result: %@", result);
             completionHandler(nil, result);
         }
     }];
}

/*
 Method to fetch the authentication token
 */
-(void)getAuthenticationToken:(FBApiCompletionHandler) completionHandler
{
    NSString *accessToken = FBSession.activeSession.accessToken;
    if(![accessToken isEqualToString:nil] || ![accessToken isEqualToString:@" "])
    {
        completionHandler(nil, accessToken);
    }
}

/*
 Method to fetch the expiry date of the token
 */
-(void)getExpiryDate:(FBApiCompletionHandler) completionHandler
{
    NSDate *expiryDate = FBSession.activeSession.expirationDate;
    if(expiryDate)
    {
        completionHandler(nil, expiryDate);
    }
}

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
 Method to delete post
 */
-(void)deletePost:(id)postIDString
{
    NSString *urlAsString = @"https://graph.facebook.com/";
    
    urlAsString = [urlAsString stringByAppendingFormat:@"%@",postIDString];
    
    urlAsString = [[urlAsString stringByAppendingString:@"?access_token="] stringByAppendingFormat:@"%@", FBSession.activeSession.accessToken];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"DELETE"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] >0 && error == nil)
         {
             NSString *responseHTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSLog(@"%@", responseHTML);
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing received from server");
         }
         else if (error != nil)
         {
             NSLog(@"Error %@", error);
         }
     }]; 
}

/*
    Method to perform a like operation
*/
-(void)likePost:(id)postId
{
    NSString *urlAsString = @"https://graph.facebook.com/";
    
    urlAsString = [urlAsString stringByAppendingFormat:@"%@",postId];
    
    urlAsString = [[urlAsString stringByAppendingString:@"/likes?access_token="] stringByAppendingFormat:@"%@", FBSession.activeSession.accessToken];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] >0 && error == nil)
         {
             NSString *responseHTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSLog(@"%@", responseHTML);
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing received from server");
         }
         else if (error != nil)
         {
             NSLog(@"Error %@", error);
         }
     }];
}

@end
