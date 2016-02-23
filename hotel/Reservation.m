//
//  Reservation.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 22/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "Reservation.h"

@interface Reservation ()

@property (nonatomic, strong) NSString *reservationId;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Offer *offer;
@property (nonatomic, strong) NSDate *dateFrom;
@property (nonatomic, strong) NSDate *dateTo;

@end

@implementation Reservation

- (instancetype)initWithDictionnary:(NSDictionary *)dic;
{
    if (self = [super init])
    {
        // TDO
#warning TODO
        
    }
    
    return self;
}

@end
