//
//  LinewikisMainViewController.h
//  Twitter
//
//  Created by Gowrisankar on 18/07/13.
//  Copyright (c) 2013 Quadrant. All rights reserved.
//

/////////////////// July22 testing Gowrisankar///////////////////

/////////////////test new//////////////////

#import "LinewikisFlipsideViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface LinewikisMainViewController : UIViewController <LinewikisFlipsideViewControllerDelegate, UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;


@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;
@property (strong, nonatomic) NSArray *dataSource;



@end
