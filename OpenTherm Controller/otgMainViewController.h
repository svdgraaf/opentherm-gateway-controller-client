//
//  otgMainViewController.h
//  OpenTherm Controller
//
//  Created by Sander van de Graaf on 19/04/14.
//  Copyright (c) 2014 42Unicorns. All rights reserved.
//

#import "otgFlipsideViewController.h"
#import "BDDROneFingerZoomGestureRecognizer.h"

@interface otgMainViewController : UIViewController <otgFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) BDDROneFingerZoomGestureRecognizer *tapZoomRecognizer;
@property float temperature;
@property float previous_pan;
@property float wanted_temperature;


@end
