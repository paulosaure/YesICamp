//
//  CustomAnnotation.h
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CustomAnnotation : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
