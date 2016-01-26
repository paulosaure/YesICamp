//
//  LocationManager.m
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "LocationManager.h"

#define LOCATION_MANAGER_DEFAULT_MAX_UPDATES_COUNT  5

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, assign) BOOL updating;
@property (nonatomic, assign) NSInteger updatesCount;

// Camping distance updates
@property (nonatomic, strong) Camping *campingToUpdate;

@end


@implementation LocationManager

#pragma mark - Shared instance

+ (instancetype)sharedInstance
{
    static LocationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Initializers

- (instancetype)init
{
    if (self = [super init])
    {
        // Initialize location manager
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 50.0;
        
        // Permissions
        [self requestPermissionsIfNeeded];
        
        // Defaults
        self.maxUpdatesCount = LOCATION_MANAGER_DEFAULT_MAX_UPDATES_COUNT;
        self.lastLocation = self.locationManager.location;
    }
    
    return self;
}

#pragma mark - Update management

- (void)updateLocation
{
    [self startLocationUpdates];
}

- (void)registerCampingForDistanceUpdates:(Camping *)camping
{
    self.campingToUpdate = camping;
}

- (void)resetAndStopLocationUpdates
{
    [self stopLocationUpdates];
    self.maxUpdatesCount = LOCATION_MANAGER_DEFAULT_MAX_UPDATES_COUNT;
}

- (void)startLocationUpdates
{
    self.updating = YES;
    self.updatesCount = 0;
    [self.locationManager startUpdatingLocation];
}

- (void)stopLocationUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.updating = NO;
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    if (!location)
        return;
    
    // Update location
    self.lastLocation = location;
    
    // Check if location manager should be stoped
    self.updatesCount++;
    if (self.maxUpdatesCount > 0 && self.updatesCount >= self.maxUpdatesCount)
    {
        [self.locationManager stopUpdatingLocation];
        self.updating = NO;
    }
    
    // Notify
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_MANAGER_DID_UPDATE_LOCATION_NOTIFICATION object:self];
    
    // Update city distances
//    [self updateCityDistancesIfNeeded];
}

#pragma mark - Permissions management

- (void)requestPermissionsIfNeeded
{
    // iOS 8 authorization request
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (BOOL)userDidRefuseLocationPermission
{
    return !([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied);
}

- (BOOL)hasLocationSeviceEnabled
{
    return ![CLLocationManager locationServicesEnabled];
}

- (void)locationManagerSetDelegate:(id)delegate
{
    self.locationManager.delegate = delegate;
}

#pragma mark - Object lifecycle

- (void)dealloc
{
    [self stopLocationUpdates];
}

@end