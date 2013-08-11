//
//  MapOverlayView.m
//  MappingMapping
//
//  Created by Umut Kanbak on 8/11/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "MapOverlayView.h"

@implementation MapOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)ctx
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
