//
//  TransitStop.h
//  MappingMapping
//
//  Created by Brad Woodard on 7/30/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TransitStop : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) CLLocationCoordinate2D stopCoordinate;
@property (strong, nonatomic) NSString *busRoutes;
@property (strong, nonatomic) NSString *direction;
@property (strong, nonatomic) NSString *interModal;


@end
