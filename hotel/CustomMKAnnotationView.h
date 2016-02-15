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

@interface CustomMKAnnotationView : MKAnnotationView

- (void)configureAnnotationWithPriceLavel:(NSString *)priceLabel color:(UIColor *)color;

@end
