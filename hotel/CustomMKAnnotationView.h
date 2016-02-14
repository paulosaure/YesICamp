//
//  CustomMKAnnotationView.h
//  YesICamp
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CustomMKAnnotationView : MKAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)identifier priceLabel:(NSString *)priceLabel;

@end
