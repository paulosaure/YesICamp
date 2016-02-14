//
//  ParamRequestHotDeal.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 13/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "ParamRequestHotDeal.h"

@interface ParamRequestHotDeal ()

@end

@implementation ParamRequestHotDeal

- (instancetype)initParamWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude locationDisplay:(NSNumber *)locationDisplay
{
    if (self = [super init])
    {
        _longitude = [longitude stringValue];
        _latitude = [latitude stringValue];
        _locationDisplay = [locationDisplay stringValue];
    }
    
    return self;
}

@end
