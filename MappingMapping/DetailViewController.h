//
//  DetailViewController.h
//  MappingMapping
//
//  Created by Brad Woodard on 7/30/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransitStop;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) TransitStop *incomingStop;

@end
