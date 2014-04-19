//
//  otgFlipsideViewController.m
//  OpenTherm Controller
//
//  Created by Sander van de Graaf on 19/04/14.
//  Copyright (c) 2014 42Unicorns. All rights reserved.
//

#import "otgFlipsideViewController.h"

@interface otgFlipsideViewController ()

@end

@implementation otgFlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
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
