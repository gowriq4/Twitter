//
//  LinewikisFlipsideViewController.h
//  Twitter
//
//  Created by Gowrisankar on 18/07/13.
//  Copyright (c) 2013 Quadrant. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinewikisFlipsideViewController;

@protocol LinewikisFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(LinewikisFlipsideViewController *)controller;
@end

@interface LinewikisFlipsideViewController : UIViewController

@property (weak, nonatomic) id <LinewikisFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
