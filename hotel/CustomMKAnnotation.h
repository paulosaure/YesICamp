//
//  CustomMKAnnotation.h
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class CustomMKAnnotationView;

@interface CustomMKAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *campingId;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;

- (id)initWithTitle:(NSString *)title price:(NSString *)price campingId:(NSString *)campingId location:(CLLocationCoordinate2D)location;
- (CustomMKAnnotationView *)annotationView;

@end
