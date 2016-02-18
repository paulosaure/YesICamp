//
//  HotDealViewController.m
//  hotel
//
//  Created by Paul Lavoine on 24/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "HotDealViewController.h"

#import <MapKit/MapKit.h>
#import "CustomMKAnnotationView.h"
#import "OfferDetail.h"
#import "HotDealCell.h"
#import "GetHotsDealsListAction.h"
#import "ScrollPagesViewController.h"
#import "CustomMKAnnotation.h"
#import "GetOffersListAction.h"

#define MINIMUM_MAP_VIEW_HEIGHT         250
#define LOCATION_DISPLAYED              15

@interface HotDealViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *extendMapButton;
@property (weak, nonatomic) IBOutlet UIButton *localizeUserButton;

// Data
@property (nonatomic, strong) NSArray *campings;
@property (nonatomic, assign) BOOL isMapExtended;
@property (nonatomic, strong) NSDate *lastRequestDate;

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
    
    self.mapView.delegate = self;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    
    // register Cell Nib
    [self.tableView registerNib:[HotDealCell cellNib] forCellReuseIdentifier:HOT_DEAL_CELL_ID];
    
    [self.view bringSubviewToFront:self.extendMapButton];
    [self.view bringSubviewToFront:self.localizeUserButton];
    
    // Add annotation
    [self configurePins];
    [self configureUI];
    [self centerMapViewOnUserLocation];
    
    // Add observer for html request
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleHotsDealsList:) name:HotsDealsListNotification object:nil];
    
    // Creation Param HTML request
    ParamRequestHotDeal *param = [[ParamRequestHotDeal alloc] initParamWithLongitude:@([LocationManager sharedInstance].lastLocation.coordinate.longitude) latitude:@([LocationManager sharedInstance].lastLocation.coordinate.latitude) locationDisplay:@(LOCATION_DISPLAYED)];
    
    // Start request action
    [[NetworkManagement sharedInstance] addNewAction:[GetHotsDealsListAction action:param]];
}

- (void)configureUI
{
    self.extendMapButton.tintColor = GREEN_COLOR;
    self.localizeUserButton.tintColor = GREEN_COLOR;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.alpha = 0.9f;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)configurePins
{
    for (int i = 0; i < [self.campings count]; i++)
    {
        Camping *camping = self.campings[i];
        CLLocationCoordinate2D location;
        location.latitude = [camping.latitude doubleValue];
        location.longitude = [camping.longitude doubleValue];
        
        NSString *price = [NSString stringWithFormat:@"%.f%@",[camping minPriceWithCamping], LOCALIZED_STRING(@"hotdeal.price_unity.label")];

        CustomMKAnnotation *annotation = [[CustomMKAnnotation alloc] initWithTitle:camping.title price:price campingId:[camping.uid stringValue] location:location];

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
    
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        CustomMKAnnotation *myLocation = (CustomMKAnnotation *)annotation;
        
        CustomMKAnnotationView *annotationView = (CustomMKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CustomMKAnnotationID];
        
        if (!annotationView)
        {
            annotationView = myLocation.annotationView;
        }
        else
        {
            annotationView.annotation = annotation;
        }

        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(CustomMKAnnotationView *)annotation
{
    if([annotation.annotation isKindOfClass:[MKUserLocation class]])
        return;

    [mapView deselectAnnotation:annotation.annotation animated:YES];
    [self.parent didSelectedTitleAtIndex:PageControllerPromo];
    // Start request action
    [[NetworkManagement sharedInstance] addNewAction:[GetOffersListAction actionWithCampingId:((CustomMKAnnotation *)annotation.annotation).campingId]];
}

#pragma mark - TableViewMethods Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.campings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    HotDealCell *cell = [tableView dequeueReusableCellWithIdentifier:HOT_DEAL_CELL_ID];
    
    // Configure cell
    [cell configureWithInformationsHotDeal:self.campings[indexPath.row] lastRequest:self.lastRequestDate];
    [cell setSeparatorVisiblity:(indexPath.row == ([self.campings count] - 1))];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Camping *camping = [self.campings objectAtIndex:indexPath.row];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([camping.latitude floatValue], [camping.longitude floatValue]);
    [self centerMapViewWithCoordinate:location];
}

#pragma mark - Actions
- (IBAction)extendMap:(id)sender
{
    [UIColor colorWithRed:64.0f/255.0f green:200.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    
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

- (IBAction)centerMapViewOnUserAction:(id)sender
{
    [self centerMapViewOnUserLocation];
}

#pragma mark - Notification

- (void)handleHotsDealsList:(NSNotification *)notif
{
    self.campings = notif.object;
    [self configurePins];
    [self.mapView reloadInputViews];
    [self.tableView reloadData];
}


#pragma mark - Utils
- (void)centerMapViewOnUserLocation
{
    [self centerMapViewWithCoordinate:[LocationManager sharedInstance].lastLocation.coordinate];
}

- (void)centerMapViewWithCoordinate:(CLLocationCoordinate2D)coordinate
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
