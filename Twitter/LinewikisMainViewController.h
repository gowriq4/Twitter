//
//  LinewikisMainViewController.h
//  Twitter
//
//  Created by Gowrisankar on 18/07/13.
//  Copyright (c) 2013 Quadrant. All rights reserved.
//

#import "LinewikisFlipsideViewController.h"

@interface LinewikisMainViewController : UIViewController <LinewikisFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
