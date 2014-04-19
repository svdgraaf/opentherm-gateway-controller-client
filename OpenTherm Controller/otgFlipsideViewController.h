//
//  otgFlipsideViewController.h
//  OpenTherm Controller
//
//  Created by Sander van de Graaf on 19/04/14.
//  Copyright (c) 2014 42Unicorns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class otgFlipsideViewController;

@protocol otgFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(otgFlipsideViewController *)controller;
@end

@interface otgFlipsideViewController : UIViewController

@property (weak, nonatomic) id <otgFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
