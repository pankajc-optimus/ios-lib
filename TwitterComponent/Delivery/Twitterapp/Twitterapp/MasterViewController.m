//
//  MasterViewController.m
//  Twitterapp
//
//  Created by Optimus on 10/16/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

@synthesize username;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //To check for the internetwork connectivity
    NSString *string=[NSString stringWithFormat:@"https://www.google.com"];
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:string]];
   
    //If data received is nil, means no internetwork 
    if(data==nil)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection failed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
    
    //To call fetTweets method
    [self fetchTweets:self.username];
    }
}

/*
 Method to fetch tweets for a particular user
*/
- (void)fetchTweets:(NSString *)nameString
{
    //Check for the username, if empty, alert is displayed.
    if([self.username length]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Username not entered" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        
    }
    else
    {
        //String of the URL to access tweets of a particular user.
   NSString *string=[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",nameString];
        
        //Data of the content of URL
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
       
         NSError* error;
        
        //Check if the username is not empty and data received is nil,means username does not exist, gives an alert.
        if(data==nil && self.username!=[NSString stringWithFormat:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Username does not exist" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           
            [alert show];
        }
        else{
            
            //String of the content of URL
            NSString *string1=[NSString stringWithContentsOfURL:[NSURL URLWithString:string] encoding:NSUTF8StringEncoding error:&error];
           
            unichar character='r';
            
            //If not authorised to access tweets, managing according to string received
            if([string1 length]!=2 && [string1 characterAtIndex:2]==character)
            {
               
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Not authorized to access " delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
            
            }
        
            else{
            
            NSError* error;
            
        
        //Array of tweets      
        tweets = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions 
                                                   error:&error];
          //To load table view   
        [self.tableView reloadData];
            }
            }
        
        }
    }

/*
 Method to set number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Tweet dictionary as the element of tweets
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    
    //Tweet to store in text object
    NSString *text = [tweet objectForKey:@"text"];
    
    //Name to store in name object
    NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    
    //For multi lines
    cell.textLabel.numberOfLines=0;
    
    //To set title as tweet
    cell.textLabel.text = text;
    
    //To set subtitle as name of the tweeter
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@", name];
    
    //Image of the tweeter to store in stringImage 
  NSString *stringImage=[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *dataImage=[NSData dataWithContentsOfURL:[NSURL URLWithString:stringImage]];

    UIImage *img=[UIImage imageWithData:dataImage];
    
    //Set image in the cell as image of the tweeter
    cell.imageView.image=img;
    return cell;
}

/* 
 Method to set the height of the cell according to the text in it.
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Element of the tweet as the dictionary 
    NSDictionary *tweet=[tweets objectAtIndex:indexPath.row];
    NSString *text=[tweet objectForKey:@"text"];
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize=CGSizeMake(280.0f, MAXFLOAT);
    CGSize size=[text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return size.height+100;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

/* 
 Method to pass the tweet data to DetailViewController.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
       
        DetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
}

@end
