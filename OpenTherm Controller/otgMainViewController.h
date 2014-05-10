//
//  otgMainViewController.h
//  OpenTherm Controller
//
//  Created by Sander van de Graaf on 19/04/14.
//  Copyright (c) 2014 42Unicorns. All rights reserved.
//

#import "otgInfoTableViewController.h"
#import "BDDROneFingerZoomGestureRecognizer.h"

@interface otgMainViewController : UIViewController <UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;
@property (strong, nonatomic) BDDROneFingerZoomGestureRecognizer *tapZoomRecognizer;
@property float temperature;
@property float previous_pan;
@property float wanted_temperature;


@end
