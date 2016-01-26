//
//  CustomAnnotation.h
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CustomAnnotation : NSObject <MKAnnotation>

- (id)initWithDictionary:(NSDictionary <NSString *, id> *)dictionary;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle;

@end
