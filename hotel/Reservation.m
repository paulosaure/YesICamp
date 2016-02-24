//
//  Reservation.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 22/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Reservation.h"

@interface Reservation ()

@end

@implementation Reservation

- (instancetype)initWithDictionnary:(NSDictionary *)dic;
{
    if (self = [super init])
    {
        _uid = [dic objectForKeyOrNil:@"id"];
        _addressCamping = [dic objectForKeyOrNil:@"address"];
        _nameCamping = [dic objectForKeyOrNil:@"camping"];
        _phoneCamping = [dic objectForKeyOrNil:@"phone"];
        _offerId = [dic objectForKeyOrNil:@"offer_id"];
        _price = [dic objectForKeyOrNil:@"price"];
        _dateFrom = [dic objectForKeyOrNil:@"begin"];
        _dateTo = [dic objectForKeyOrNil:@"end"];
        _statusReservation = [dic objectForKeyOrNil:@"status"];
    }
    
    return self;
}

@end
