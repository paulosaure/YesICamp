//
//  GetReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 23/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "GetReservationAction.h"

#define RESERVATIONS_URL      @"user/bookings"

@implementation GetReservationAction

#pragma mark - Constructor

+ (instancetype)action
{
    GetReservationAction *action = [[GetReservationAction alloc] initWithUrl:ACTION_URL(RESERVATIONS_URL) service:WebServiceGetReservationList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSMutableArray *reservations = [NSMutableArray array];
    
    // Get data
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSString *body = [obj objectForKey:RESPONSE_BODY];
    
    // Transform body to Json
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *bodyReservations = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if (header.statusCode == 200)
    {
        for (NSDictionary *reservation in bodyReservations)
        {
            [reservations addObject:[[Reservation alloc] initWithDictionnary:reservation]];
        }
        
        [User sharedInstance].reservations = reservations;
        [NOTIFICATION_CENTER postNotificationName:ReservationListNotification object:reservations];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:ReservationListNotification object:nil];
    }
}

@end
