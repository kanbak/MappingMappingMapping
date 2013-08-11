//
//  TransitStop.m
//  MappingMapping
//
//  Created by Brad Woodard on 7/30/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "TransitStop.h"

@implementation TransitStop
@synthesize stopCoordinate;
@synthesize title;
@synthesize busRoutes;

- (CLLocationCoordinate2D)coordinate
{
    return stopCoordinate;
}

- (NSString *)subtitle
{
    return busRoutes;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nTitle: %@\nLatitude: %f\nLongitude: %f\n%@", title, stopCoordinate.latitude, stopCoordinate.longitude, busRoutes];
}

@end
