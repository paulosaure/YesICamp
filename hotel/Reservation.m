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

+ (NSString *)reservationStatusLabelWithString:(NSString *)status
{
    NSString *reservationStatus = @"Unknown";
    
    if ([status isEqualToString:@"to_pay"]) {
        reservationStatus = LOCALIZED_STRING(@"reservation.reservation_status.payed");
    } else if ([status isEqualToString:@"payment_in_progress"]) {
        reservationStatus = LOCALIZED_STRING(@"reservation.reservation_status.in_progress");
    } else if ([status isEqualToString:@"Lux"]) {
        reservationStatus = LOCALIZED_STRING(@"reservation.reservation_status.failed");
    } else {
        NSLog(@"Status Paiement Inconnue : %@", status);
    }
    
    return reservationStatus;
}

+ (ReservationStatus)reservationStatusWithString:(NSString *)status
{
    ReservationStatus reservationStatus;
    
    if ([status isEqualToString:LOCALIZED_STRING(@"reservation.reservation_status.payed")]) {
        reservationStatus = ReservationStatusPayed;
    } else if ([status isEqualToString:LOCALIZED_STRING(@"reservation.reservation_status.in_progress")]) {
        reservationStatus = ReservationStatusInProgress;
    } else if ([status isEqualToString:LOCALIZED_STRING(@"reservation.reservation_status.failed")]) {
        reservationStatus = ReservationStatusFailed;
    } else {
        reservationStatus = ReservationStatusUnknown;
    }
    
    return reservationStatus;
}

+ (UIColor *)colorWithReservationStatus:(ReservationStatus)status
{
    switch (status) {
        case ReservationStatusPayed:
            return [UIColor greenColor];
        case ReservationStatusInProgress:
            return [UIColor orangeColor];
        case ReservationStatusFailed:
            return [UIColor redColor];
        default:
            return [UIColor whiteColor];
            break;
    }
}

+ (UIColor *)colorWithReservationStatusString:(NSString *)status
{
    return [self colorWithReservationStatus:[self reservationStatusWithString:status]];
}

@end
