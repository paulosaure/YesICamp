//
//  CustomAnnotation.m
//  hotel
//
//  Created by Paul Lavoine on 26/01/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "CustomAnnotation.h"

@interface CustomAnnotation ()

@end

@implementation CustomAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
    }
    
    return self;
}

- (NSString *)title
{
    return self.title;
}

- (NSString *)subtitle
{
    return self.subtitle;
}

@end
