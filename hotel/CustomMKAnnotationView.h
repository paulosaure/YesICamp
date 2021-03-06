//
//  CustomMKAnnotationView.h
//  YesICamp
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define CustomMKAnnotationID @"CustomMKAnnotationID"
#define USER_LOCATION_MARKER_WIDTH      25
#define MARGE 10

@class CustomMKAnnotation;

@interface CustomMKAnnotationView : MKAnnotationView

- (void)configureAnnotationWith:(CustomMKAnnotation *)annotation;
+ (NSInteger)widthPrice:(NSString *)price;

@end
