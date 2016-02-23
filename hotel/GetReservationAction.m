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

+ (instancetype)actionWithUid:(NSString *)uid tokenId:(NSString *)tokenId client:(NSString *)client
{
    NSString *urlSuffix = [NSString stringWithFormat:@"%@?uid=%@&tokenId=%@&client=%@",RESERVATIONS_URL, uid, tokenId, client];
    GetReservationAction *action = [[GetReservationAction alloc] initWithUrl:ACTION_URL(urlSuffix) service:WebServiceGetReservationList];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSMutableArray *reservations = [NSMutableArray array];
    NSData *data = [[obj objectForKey:RESPONSE_BODY] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *reservationsJson = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    

    for (NSDictionary *reservation in reservationsJson)
    {
        [reservations addObject:[[Reservation alloc] initWithDictionnary:reservation]];
    }
    
    [NOTIFICATION_CENTER postNotificationName:ReservationListNotification object:reservations];
}

@end
