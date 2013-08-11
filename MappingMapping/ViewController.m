//
//  ViewController.m
//  MappingMapping
//
//  Created by Brad Woodard on 7/30/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "TransitStop.h"


@interface ViewController ()
{
    __weak IBOutlet MKMapView   *mapViewOutlet;
    NSArray                     *busStopsArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    // Alloc & init TransitStop object
    TransitStop *transitStop = [[TransitStop alloc] init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake(41.8863, -87.6378);
    MKCoordinateSpan startSpan = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion startRegion = MKCoordinateRegionMake(startCoordinate, startSpan);
    
    mapViewOutlet.showsUserLocation = YES;
    mapViewOutlet.region = startRegion;
    
    [self retrieveCTAData];
    
    [mapViewOutlet addAnnotation:transitStop];
    
    CLLocationCoordinate2D myCoords[6]={
		CLLocationCoordinate2DMake(41.8863, -87.6378),
        CLLocationCoordinate2DMake(41.8884, -87.6252),
        CLLocationCoordinate2DMake(41.8842, -87.6134),
        CLLocationCoordinate2DMake(41.8779, -87.6401),
        CLLocationCoordinate2DMake(41.8768, -87.6276),
        CLLocationCoordinate2DMake(41.8779, -87.6173),
        
	};
    MKPolygon *myOverlay=[MKPolygon polygonWithCoordinates:myCoords count:6];
	[mapViewOutlet addOverlay:myOverlay];
    
}
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	if([overlay isKindOfClass:[MKPolygon class]]){
		MKPolygonView *oview = [[MKPolygonView alloc] initWithOverlay:overlay];
		oview.lineWidth=1;
		oview.strokeColor=[UIColor blueColor];
		oview.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];}


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[TransitStop class]]) {
        
        MKAnnotationView *annotationView = [mapViewOutlet dequeueReusableAnnotationViewWithIdentifier:@"AnnotationIdentifier"];
        
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationIdentifier"];
            
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.image=[UIImage imageNamed:@"busIcon-20x24.png"];
        
        return annotationView;

    } else {
        return nil;
    }
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
//    TransitStop *selectedStop = [[TransitStop alloc] init];    
    TransitStop *selectedStop = (TransitStop *) view.annotation; // captures the tapped annotation

    // Create pointer to the detail view
    DetailViewController *detailViewController;

    
    // Perform the segue
    [self performSegueWithIdentifier:@"toDetailView" sender:self];
    
    detailViewController = (DetailViewController *) [self.navigationController.viewControllers lastObject];
    detailViewController.incomingStop = selectedStop;

}





#pragma mark - RetrieveCTAData
- (void)retrieveCTAData
{
    NSURL *url = [NSURL URLWithString:@"http://mobilemakers.co/lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *allBusStopDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSArray *arrayOfBusStops = [allBusStopDictionary objectForKey:@"row"];
        
        [arrayOfBusStops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //  Adding error checking to our block to ensure the objects being returned
            //  are NSDictionary objects. If not, log an error.
            
            if ([obj isKindOfClass:[NSDictionary class]]) {
                TransitStop *newStop = [[TransitStop alloc] init];
                
                newStop.title = [obj objectForKey:@"cta_stop_name"];
                
                CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake([[obj objectForKey:@"latitude"] floatValue], [[obj objectForKey:@"longitude"] floatValue]);
                
                newStop.stopCoordinate = newCoordinate;
                newStop.busRoutes = [obj objectForKey:@"routes"];
                newStop.direction = [obj objectForKey:@"direction"];
                newStop.interModal = [obj objectForKey:@"inter_modal"];
                
                [mapViewOutlet addAnnotation:newStop];
    

            } else {
                NSLog(@"ERROR: %@", error.description);
            }
            
        }];
    }];
}

@end
