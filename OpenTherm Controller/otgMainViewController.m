//
//  otgMainViewController.m
//  OpenTherm Controller
//
//  Created by Sander van de Graaf on 19/04/14.
//  Copyright (c) 2014 42Unicorns. All rights reserved.
//

#import "otgMainViewController.h"
#import "BDDROneFingerZoomGestureRecognizer.h"
#import "RKObjectManager.h"

@interface otgMainViewController ()

@end

@implementation otgMainViewController

@synthesize temperature;
@synthesize wanted_temperature;
@synthesize temperatureLabel;
@synthesize tapZoomRecognizer;
@synthesize previous_pan;
@synthesize activitySpinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.temperature = 20.0f;
    [self.temperatureLabel setText:[NSString stringWithFormat:@"%.0fº", self.temperature]];
    [self.view setBackgroundColor:[self colorForDegrees:self.temperature]];
    [self.activitySpinner stopAnimating];
    
    self.previous_pan = 0;
    self.tapZoomRecognizer = [[BDDROneFingerZoomGestureRecognizer alloc] initWithTarget:self action:@selector(tapZoom:)];
    [self.tapZoomRecognizer setBouncesScale:NO];
//    [self.tapZoomRecognizer setMaximumScale:1.0];
//    [self.tapZoomRecognizer setMinimumScale:-1.0];
    [self.view addGestureRecognizer:self.tapZoomRecognizer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

//- (void)flipsideViewControllerDidFinish:(otgFlipsideViewController *)controller
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.flipsidePopoverController dismissPopoverAnimated:YES];
//    }
//}

- (void)tapZoom:(BDDROneFingerZoomGestureRecognizer *)recognizer{
    float scale;
    if(self.previous_pan < recognizer.scale) {
//        up
        scale = recognizer.scale / 10;
    } else {
//        down
        scale = (recognizer.scale * -1) / 10;
    }
    self.previous_pan = recognizer.scale;
    NSLog(@"recognizer: %f", scale);
    [self updateTemperatureViewForRecognizerState:recognizer.state withScale:scale];
}

- (void)updateTemperatureViewForRecognizerState:(UIGestureRecognizerState *)state withScale:(float)scale {
    if(self.temperature + scale <= 40 && self.temperature + scale > 0) {
        self.wanted_temperature = self.temperature + scale;
        [self.temperatureLabel setText:[NSString stringWithFormat:@"%.0fº", self.wanted_temperature]];
        [self.view setBackgroundColor:[self colorForDegrees:self.wanted_temperature]];
        
        if (state == UIGestureRecognizerStateEnded) {
            [self setTargetTemperature:self.wanted_temperature];
            [self commitTemperature:self.wanted_temperature];
            self.previous_pan = 0;
        }
        [self setTargetTemperature:scale];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)respondToRotation:(UIRotationGestureRecognizer *)recognizer{
    NSLog(@"%f", recognizer.rotation);
    float scale;
    scale = recognizer.rotation / 5;
    self.previous_pan = recognizer.rotation;

    [self updateTemperatureViewForRecognizerState:recognizer.state withScale:scale];
}


- (UIColor *)colorForDegrees:(float)target_temperature {
    float t = (target_temperature - 1) / (40 - 1);
    
    // Clamp t to the range [0 ... 1].
    t = MAX(0.0, MIN(t, 1.0));
    
    double r = 0 + t * (255 - 0);
    double g = 0 + t * (0 - 0);
    double b = 255 + t * (0 - 255);
    
    return [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
}

 - (void)setTargetTemperature:(float)target_temperature {
    self.temperature = self.wanted_temperature;
}

- (void)commitTemperature:(float)target_temperature {
    RKObjectManager *object_manager = [RKObjectManager sharedManager];
    AFHTTPClient *client = object_manager.HTTPClient;
    [client postPath:@"temperature" parameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.0f", target_temperature], @"temperature", nil] success:nil failure:nil];
}


//
//- (IBAction)respondToHold:(UILongPressGestureRecognizer *)recognizer{
//    if (recognizer.state == UIGestureRecognizerStateEnded)
//    {
//        self.temperature = self.wanted_temperature;
//    }
//}


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
