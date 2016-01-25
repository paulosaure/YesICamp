//
//  HotDealViewController.m
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HotDealViewController.h"

#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "ProfilViewController.h"

@interface HotDealViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation HotDealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    CLLocation *userLocation = [[LocationManager sharedInstance] lastLocation];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if (![[LocationManager sharedInstance] userDidRefuseLocationPermission])
    {
        [self.locationManager startUpdatingLocation];
//        [[LocationManager sharedInstance] updateLocation];
        self.mapView.showsUserLocation = YES;
        
    }
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"test");
}

#pragma mark - MKAnnotation

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //use whatever annotation class you used when creating the annotation
    if ([annotation isKindOfClass:[CustomAnnotation class]])    {
        static NSString * const identifier = @"MyCustomAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"your-image-here.png"];
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    ProfilViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:ProfilViewControllerID];
//  controller.annotation = view.annotation; // it's useful to have property in your view controller for whatever data it needs to present the annotation's details
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
