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
#import "HotDealCell.h"

#define USER_LOCATION_MARKER_WIDTH      20
#define MINIMUM_MAP_VIEW_HEIGHT         250
@interface HotDealViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *extendMapButton;
@property (weak, nonatomic) IBOutlet UIButton *localizeUserButton;

// Data
@property (nonatomic, strong) NSArray *hotDeals;
@property (nonatomic, assign) BOOL isMapExtended;

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
    
    // register Cell Nib
    [self.tableView registerNib:[HotDealCell cellNib] forCellReuseIdentifier:HOT_DEAL_CELL_ID];
    
    [self.view bringSubviewToFront:self.extendMapButton];
    [self.view bringSubviewToFront:self.localizeUserButton];
    
    [self configurePins];
}

- (void)configurePins
{
    NSArray *arrayLat = @[@46.40756396630067, @46.27863122156088, @44.86365630540611, @43.58834891179793, @43.644025847699496];
    NSArray *arrayLon = @[@1.3367271423339844, @2.7539634704589844, @(-0.5529212951660156), @1.5125083923339844, @3.8855552673339844];
    
    for (int i = 0; i < [arrayLat count]; i++)
    {
        CLLocationCoordinate2D location;
        location.latitude = [arrayLat[i] doubleValue];
        location.longitude = [arrayLon[i] doubleValue];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:location];
        [annotation setTitle:@"Title"]; //You can set the subtitle too
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    NSLog(@"MapView didUpdateUserLocation");
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"LocationManager didUpdateLocations");
}

#pragma mark - MKAnnotation

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *view = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([CustomAnnotation class])];
    
    if (!view)
    {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:NSStringFromClass([CustomAnnotation class])];
        UIImage *image = [UIImage imageNamed:@"marker"];
        view.image = image;
        CGRect temp = view.frame;
        temp.size =  CGSizeMake(USER_LOCATION_MARKER_WIDTH, USER_LOCATION_MARKER_WIDTH * image.size.height/image.size.width);
        view.frame = temp;
        view.canShowCallout = YES;
        view.centerOffset = CGPointMake(view.centerOffset.x, -view.frame.size.height/2);
    }
    
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotation
{
    if([annotation.annotation isKindOfClass:[MKUserLocation class]])
        return;
    
    [mapView deselectAnnotation:annotation.annotation animated:YES];
    
    [NOTIFICATION_CENTER postNotificationName:HotDealNotification object:nil];
}

#pragma mark - TableViewMethods Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;[self.hotDeals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    HotDealCell *cell = [tableView dequeueReusableCellWithIdentifier:HOT_DEAL_CELL_ID];
    
    // Configure cell
    [cell configureWithInformationsHotDeal:self.hotDeals[indexPath.row]];
    
    return cell;
}

#pragma mark - Actions
- (IBAction)extendMap:(id)sender
{
    [self.view layoutIfNeeded];
    if (!self.isMapExtended)
    {
        self.mapViewHeightConstraint.constant = CGRectGetHeight(self.view.frame);
    }
    else
    {
        self.mapViewHeightConstraint.constant = MINIMUM_MAP_VIEW_HEIGHT;
    }
    self.isMapExtended = !self.isMapExtended;
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
}

- (IBAction)centreMapViewOnUserAction:(id)sender
{
    [self centreMapViewWithCoordinate:self.mapView.userLocation.location.coordinate];
}

#pragma mark - Utils
- (void)centreMapViewWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    region.span = span;
    region.center = coordinate;
    [self.mapView setRegion:region animated:YES];
}


@end
