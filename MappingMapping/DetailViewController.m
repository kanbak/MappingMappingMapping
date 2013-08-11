//
//  DetailViewController.m
//  MappingMapping
//
//  Created by Brad Woodard on 7/30/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "DetailViewController.h"

#import "TransitStop.h"

@interface DetailViewController ()
{
    __weak IBOutlet UILabel *directionLabel;
    __weak IBOutlet UILabel *routesLabel;    
    __weak IBOutlet UILabel *transfersLabel;
}

@end

@implementation DetailViewController
@synthesize incomingStop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    directionLabel.text = inc
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationItem.title = self.incomingStop.title;
    directionLabel.text = incomingStop.direction;
    routesLabel.text = incomingStop.busRoutes;
    transfersLabel.text = incomingStop.interModal;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
