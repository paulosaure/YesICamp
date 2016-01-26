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

- (id)initWithDictionary:(NSDictionary <NSString *, id> *)dictionary {
    
    NSDictionary * coordinateDictionary = [dictionary objectForKey:@"coordinates"];
    
    return [self initWithCoordinates:CLLocationCoordinate2DMake([[coordinateDictionary objectForKey:@"latitude"] doubleValue], [[coordinateDictionary objectForKey:@"longitude"] doubleValue])
                               title:[dictionary objectForKey:@"name"]
                            subtitle:nil];
}

- (id)initWithCoordinates:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle
{
    if (self = [super init])
    {
        _coordinate = location;
        _title = title;
        _subtitle = subtitle;
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
