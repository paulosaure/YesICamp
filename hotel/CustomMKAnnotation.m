//
//  CustomMKAnnotation.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 18/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CustomMKAnnotation.h"
#import "CustomMKAnnotationView.h"

@interface CustomMKAnnotation ()

@end

@implementation CustomMKAnnotation 

- (id)initWithTitle:(NSString *)title price:(NSString *)price campingId:(NSString *)campingId location:(CLLocationCoordinate2D)location
{
    if (self = [super init])
    {
        _title = title;
        _coordinate = location;
        _campingId = campingId;
        _price = price;
    }
    
    return self;
}

- (CustomMKAnnotationView *)annotationView
{
    CustomMKAnnotationView *annotationView = [[CustomMKAnnotationView alloc] initWithAnnotation:self
                                                        reuseIdentifier:CustomMKAnnotationID];
    
    annotationView.centerOffset = CGPointMake(USER_LOCATION_MARKER_WIDTH/2, -annotationView.frame.size.height);
    annotationView.canShowCallout = NO;
    annotationView.frame = CGRectMake(0, 0, USER_LOCATION_MARKER_WIDTH + [CustomMKAnnotationView widthPrice:self.price] + MARGE, USER_LOCATION_MARKER_WIDTH);
    [annotationView configureAnnotation];
    
    return annotationView;
}

@end
