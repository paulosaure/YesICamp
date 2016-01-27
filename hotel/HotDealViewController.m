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
#import "AnnotationView.h"

#define USER_LOCATION_WIDTH 20

@interface HotDealViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation HotDealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![[LocationManager sharedInstance] userDidRefuseLocationPermission])
    {
        [[LocationManager sharedInstance] updateLocation];
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

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *view = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([CustomAnnotation class])];
    
    if (!view)
    {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:NSStringFromClass([CustomAnnotation class])];
        UIImage *image = [UIImage imageNamed:@"marker"];
        view.image = image;
        CGRect temp = view.frame;
        temp.size =  CGSizeMake(USER_LOCATION_WIDTH, USER_LOCATION_WIDTH * image.size.height/image.size.width);
        view.frame = temp;
        view.canShowCallout = YES;
        view.centerOffset = CGPointMake(view.centerOffset.x, -view.frame.size.height/2);
    }
    
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    ProfilViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:ProfilViewControllerID];
    //  controller.annotation = view.annotation; // it's useful to have property in your view controller for whatever data it needs to present the annotation's details
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
