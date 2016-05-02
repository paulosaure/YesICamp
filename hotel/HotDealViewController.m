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
#import "OfferCell.h"
#import "GetHotsDealsListAction.h"
#import "ScrollPagesViewController.h"
#import "CustomMKAnnotation.h"
#import "GetOffersListAction.h"
#import "GetOfferDetailAction.h"

#define MINIMUM_MAP_VIEW_HEIGHT         250
#define LOCATION_DISPLAYED              15

@interface HotDealViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

// Outlets
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *extendMapButton;
@property (weak, nonatomic) IBOutlet UIButton *localizeUserButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

// Data
@property (nonatomic, strong) NSArray *campings;
@property (nonatomic, strong) NSMutableArray *offers;
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
    
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
   
    // register Cell Nib
    [self.tableView registerNib:[OfferCell cellNib] forCellReuseIdentifier:OFFER_CELL_IDENTIFIER];
    
    // Add annotation
    [self configurePins];
    [self configureUI];
    [self centerMapViewOnUserLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    
    [self.view bringSubviewToFront:self.extendMapButton];
    [self.view bringSubviewToFront:self.localizeUserButton];
    
    // Add observer for html request
    [NOTIFICATION_CENTER addObserver:self selector:@selector(handleHotsDealsList:) name:HotsDealsListNotification object:nil];
    
    if (!self.offers)
    {
        // Creation Param HTML request
        ParamRequestHotDeal *param = [[ParamRequestHotDeal alloc] initParamWithLongitude:@([LocationManager sharedInstance].lastLocation.coordinate.longitude) latitude:@([LocationManager sharedInstance].lastLocation.coordinate.latitude) locationDisplay:@(LOCATION_DISPLAYED)];
        
        // Start request action
        [[NetworkManagement sharedInstance] addNewAction:[GetHotsDealsListAction action:param]];
        [self isSearching:YES];
        [self performSelector:@selector(cancelRequest) withObject:self afterDelay:30];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [NOTIFICATION_CENTER removeObserver:self];
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
        
        Offer *offer = [camping offerMinPriceWithCamping];
        NSString *price = [NSString stringWithFormat:@"%.f%@",[offer.price floatValue], LOCALIZED_STRING(@"globals.unity")];
        
        CustomMKAnnotation *annotation = [[CustomMKAnnotation alloc] initWithTitle:offer.title price:price campingId:[offer.uid stringValue] location:location];
        
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

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(CustomMKAnnotation *)annotation
{
    
    if ([annotation isKindOfClass:[CustomMKAnnotation class]])
    {
        CustomMKAnnotationView *annotationView = (CustomMKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CustomMKAnnotationID];
        
        if (annotationView == nil)
        {
            annotationView = annotation.annotationView;
        }
        else
        {
            [annotationView configureAnnotationWith:annotation];
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
//    [self.parent setHeaderSectionWithString:annotation.annotation.title];
//    [self.parent didSelectedTitleAtIndex:PageControllerPromo];
    
    
    // Get camping
    Offer *offer = [self offerWithId:((CustomMKAnnotation *)annotation.annotation).campingId];
    [NOTIFICATION_CENTER postNotificationName:PushOfferDetailViewNotificiation object:offer];
}

#pragma mark - TableViewMethods Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.offers count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue cell
    OfferCell *cell = [tableView dequeueReusableCellWithIdentifier:OFFER_CELL_IDENTIFIER];
    
    // Configure cell
    [cell configureWithOffer:self.offers[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get camping
    Offer *offer = self.offers[indexPath.row];
    [NOTIFICATION_CENTER postNotificationName:PushOfferDetailViewNotificiation object:offer];
    
    
//    Camping *camping = [self.campings objectAtIndex:indexPath.row];
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([camping.latitude floatValue], [camping.longitude floatValue]);
//    [self centerMapViewWithCoordinate:location];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIScreen mainScreen] bounds].size.height <= 480.0f)
        return self.tableView.frame.size.height - 40;
    
    return (2*self.tableView.frame.size.height) / 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    label.textColor = [UIColor whiteColor];
    NSString *string = [LOCALIZED_STRING(@"hotdeal.header_section.title") uppercaseString];
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:GREEN_COLOR];
    return view;
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
    self.offers = [NSMutableArray array];
    
    for (Camping *camping in self.campings)
    {
        for (Offer *offer in camping.offers)
        {
            [self.offers addObject:offer];
        }
    }
    
    [self configurePins];
    [self.mapView reloadInputViews];
    [self.tableView reloadData];
    [self isSearching:NO];
}


#pragma mark - Utils

- (Offer *)offerWithId:(NSString *)uid
{
    for (Offer *offer in self.offers)
    {
        if ([[offer.uid stringValue] isEqualToString:uid])
            return offer;
    }
    
    return nil;
}

- (void)cancelRequest
{
    [self isSearching:NO];
}

- (void)isSearching:(BOOL)isSearching
{
    self.spinner.hidden = !isSearching;
    //    self.startSearchButton.hidden = isSearching;
    isSearching ? [self.spinner startAnimating] : [self.spinner stopAnimating];
}

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
