//
//  LinewikisMainViewController.m
//  Twitter
//
//  Created by Gowrisankar on 18/07/13.
//  Copyright (c) 2013 Quadrant. All rights reserved.
//

#import "LinewikisMainViewController.h"

#import <Twitter/TWRequest.h>
#import <Twitter/TWTweetComposeViewController.h>
#import <Social/Social.h>
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountCredential.h>
////// main/////////

@interface LinewikisMainViewController ()
{
    NSString *tw_username;
    NSString *tw_userid;
    NSString *tw_fullname;
}
@end

@implementation LinewikisMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //defect Id-# :qfor:gowrisankar:start:twitter feed call..
    [self Twitter];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)getTimeLine {
    
    
    if ([TWTweetComposeViewController canSendTweet])
    {
        ACAccountStore *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account
                                      accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [account requestAccessToAccountsWithType:accountType
                                         options:nil completion:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray *arrayOfAccounts = [account
                                             accountsWithAccountType:accountType];
                 
                 if ([arrayOfAccounts count] > 0)
                 {
                     ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                     
                     NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1.1/statuses/home_timeline.json"];
                     
                     NSMutableDictionary *parameters =
                     [[NSMutableDictionary alloc] init];
                     [parameters setObject:@"20" forKey:@"count"];
                     [parameters setObject:@"1" forKey:@"include_entities"];
                     
                     SLRequest *postRequest = [SLRequest
                                               requestForServiceType:SLServiceTypeTwitter
                                               requestMethod:SLRequestMethodGET
                                               URL:requestURL parameters:parameters];
                     
                     postRequest.account = twitterAccount;
                     
                     [postRequest performRequestWithHandler:
                      ^(NSData *responseData, NSHTTPURLResponse
                        *urlResponse, NSError *error)
                      {
                          self.dataSource = [NSJSONSerialization
                                             JSONObjectWithData:responseData
                                             options:NSJSONReadingMutableLeaves
                                             error:&error];
                          
                          NSLog(@"Timeline Response: %@\n", self.dataSource);
                          
                          
                          
                          
                          if (self.dataSource.count != 0) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [self.tweetTableView reloadData];
                              });
                          }
                      }];
                 }
             } else {
                 // Handle failure to get account access
             }
         }];

        
    }else{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please create your Twitter account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
     
    }
    
    
}

-(void)Twitter
{
    
    
//if ([TWTweetComposeViewController canSendTweet])
//{
    
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [accountStore
                                         
                                         accountTypeWithAccountTypeIdentifier:
                                         
                                         ACAccountTypeIdentifierTwitter];
    
    [accountStore
     
     requestAccessToAccountsWithType:twitterAccountType
     
     options:NULL
     
     completion:^(BOOL granted, NSError *error) {
         
         if (granted) {
             
             //  Step 2:  Create a request
             
             NSArray *twitterAccounts =
             
             [accountStore accountsWithAccountType:twitterAccountType];
             
             NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
             
//             NSMutableDictionary *params =
//             [[NSMutableDictionary alloc] init];
//             [params setObject:@"1" forKey:@"count"];
//             [params setObject:@"1" forKey:@"include_entities"];
             
//           NSDictionary *params = @{@"screen_name" : @"TruckTrendcom",
//                                      
//                                      @"include_rts" : @"0",
//                                      
//                                      @"trim_user" : @"1",
//                                      
//                                      @"count" : @"1"};
             
             
             
             NSDictionary *params = @{@"screen_name" : @"TruckTrendcom",
                                      
                                     
                                      
                                     
                                      
                                      @"page" : @"0",
                                      
                                      @"count" : @"20"};
             
             
             
             SLRequest *request =
             
             [SLRequest requestForServiceType:SLServiceTypeTwitter
              
                                requestMethod:SLRequestMethodGET
              
                                          URL:url
              
                                   parameters:params];
             
             
             
             //  Attach an account to the request
             
             [request setAccount:[twitterAccounts lastObject]];
             
             
             
             //  Step 3:  Execute the request
             
             [request performRequestWithHandler:^(NSData *responseData,
                                                  
                                                  NSHTTPURLResponse *urlResponse,
                                                  
                                                  NSError *error) {
                 
                 if (responseData) {
                     
                     if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                         
                         NSError *jsonError;
                         
                         NSDictionary *timelineData =
                         
                         [NSJSONSerialization
                          
                          JSONObjectWithData:responseData
                          
                          options:NSJSONReadingAllowFragments error:&jsonError];
                         
                         
                         
                         if (timelineData) {
                             
                             NSLog(@"Timeline Response: %@\n", timelineData);
                             
                         }
                         
                         else {
                             
                             // Our JSON deserialization went awry
                             
                             NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                             
                         }
                         
                     }
                     
                     else {
                         
                         // The server did not respond successfully... were we rate-limited?
                         
                         NSLog(@"The response status code is %d", urlResponse.statusCode);
                         
                     }
                     
                 }
                 
             }];
             
         }
         
         else {
             
             // Access was not granted, or an error occurred
             
             NSLog(@"%@", [error localizedDescription]);
             
         }
         
     }];
    
//}else{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please create your Twitter account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
//    
//}


}


-(void)tweetLoginView{
  
    if ([TWTweetComposeViewController canSendTweet])
    {
        ACAccountStore  *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray   *arrayOfAccounts = [account accountsWithAccountType:accountType];
                 ACAccount *ac=[arrayOfAccounts objectAtIndex:0];
                 NSLog(@"arrayOfAccounts %@",[(ACAccount*)[arrayOfAccounts objectAtIndex:0] username]);
                 
                 [[NSUserDefaults standardUserDefaults] setObject:ac.username forKey:@"Twitter_name"];
                 
                 tw_username = [(ACAccount*)[arrayOfAccounts objectAtIndex:0] username];
                 tw_userid = [[ac valueForKey:@"properties"] objectForKey:@"user_id"];
                 tw_fullname = [[ac valueForKey:@"properties"] objectForKey:@"fullName"];
                // [self performSelector:@selector(twitter_webservice)];
                 
                 
                 NSLog(@"tw_username-->%@",tw_username);
                 NSLog(@"tw_username-->%@",tw_userid);
                 NSLog(@"tw_username-->%@",tw_fullname);
                 

             }
         }];
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please create your Twitter account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
      
    }
}



#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tweetTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    
    cell.textLabel.text = tweet[@"text"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(LinewikisFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

@end
