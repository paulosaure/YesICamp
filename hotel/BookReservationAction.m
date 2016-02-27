//
//  MakeReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "BookReservationAction.h"

#define RESERVATION_URL @"user/book"

@implementation BookReservationAction

#pragma mark - Constructor

+ (instancetype)actionWithOfferId:(NSString *)offerId dateBegin:(NSString *)dateBegin dateEnd:(NSString *)dateEnd
{
    NSString *postCardParam = [NSString stringWithFormat:@"offer_id=%@&begin=%@&end=%@",offerId, dateBegin, dateEnd];
    BookReservationAction *action = [[BookReservationAction alloc] initWithUrl:ACTION_URL(RESERVATION_URL) service:WebServiceMakeReservation param:postCardParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *bookingJson = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSNumber *bookingID = [bookingJson objectForKey:@"id"];
    
    if (header.statusCode == 200)
    {
        [NOTIFICATION_CENTER postNotificationName:didBookReservationSuccededNotification object:bookingID];
    }
    else
    {
        [NOTIFICATION_CENTER postNotificationName:didBookReservationFailedNotification object:nil];
    }
}

@end
