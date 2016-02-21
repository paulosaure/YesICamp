//
//  MakeReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "MakeReservationAction.h"

#define RESERVATION_URL @""

@implementation MakeReservationAction

#pragma mark - Constructor

+ (instancetype)action
{
    MakeReservationAction *action = [[MakeReservationAction alloc] initWithUrl:ACTION_URL(RESERVATION_URL) service:WebServiceMakeReservation];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSDictionary *body = [obj objectForKey:RESPONSE_BODY];
    NSString *response = @"";
    
    if (header.statusCode != 200)
    {

    }
    else
    {

    }
    
    [NOTIFICATION_CENTER postNotificationName:DidReservationNotification object:response];
}

@end
