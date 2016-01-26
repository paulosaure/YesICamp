//
//  LocationManager.h
//  hotel
//
//  Created by Paul Lavoine on 25/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_MANAGER_DID_UPDATE_LOCATION_NOTIFICATION   @"LOCATION_MANAGER_DID_UPDATE_LOCATION"

@class Camping;

@interface LocationManager : NSObject

/**
 Shared instance
 */
+ (instancetype)sharedInstance;

/**
 Start updating location
 */
- (void)updateLocation;

/**
 Wether or not the use refused the permission to access the location
 
 @return YES if use refused the permission, NO otherwise
 */
- (BOOL)userDidRefuseLocationPermission;

/**
 Wether or not the system has location service enabled
 
 @return YES if use refused the permission, NO otherwise
 */
- (BOOL)hasLocationSeviceEnabled;

/**
 Register a city for distance updates, places and addresses will be updated in a background
 thread
 */
- (void)registerCampingForDistanceUpdates:(Camping *)camping;

/**
 Resets instance to default values and stop location updates
 */
- (void)resetAndStopLocationUpdates;

- (void)locationManagerSetDelegate:(id)delegate;

/**
 Max number of updates before stopping the location manager, Defaults is 5
 When set to 0, the location manager never stops
 */
@property (nonatomic, assign) NSInteger maxUpdatesCount;

/**
 Last retrieved location
 */
@property (nonatomic, strong, readonly) CLLocation *lastLocation;

/**
 Wether or not the location manager is upading
 */
@property (nonatomic, assign, readonly) BOOL updating;

@end
