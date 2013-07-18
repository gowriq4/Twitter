//
//  LinewikisFlipsideViewController.m
//  Twitter
//
//  Created by Gowrisankar on 18/07/13.
//  Copyright (c) 2013 Quadrant. All rights reserved.
//

#import "LinewikisFlipsideViewController.h"

@interface LinewikisFlipsideViewController ()

@end

@implementation LinewikisFlipsideViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
