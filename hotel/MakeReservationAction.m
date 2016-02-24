//
//  MakeReservationAction.m
//  Yes I Camp
//
//  Created by Paul Lavoine on 21/02/2016.
//  Copyright © 2016 Paul Lavoine. All rights reserved.
//

#import "MakeReservationAction.h"

#define RESERVATION_URL @"user/book"

@implementation MakeReservationAction

#pragma mark - Constructor

+ (instancetype)actionWithOfferId:(NSString *)offerId dateBegin:(NSString *)dateBegin dateEnd:(NSString *)dateEnd redactedCardNumber:(NSString *)redactedCardNumber expiryMonth:(unsigned long)expiryMonth expiryYear:(unsigned long)expiryYear cvv:(NSString *)cvv
{
    NSString *postCardParam = [NSString stringWithFormat:@"offer_id=%@&begin=%@&end=%@&redactedCardNumber=%@&expiryMonth=%lu&expiryYear=%lu&cvv=%@",offerId, dateBegin, dateEnd, redactedCardNumber,expiryYear ,expiryMonth, cvv];
    MakeReservationAction *action = [[MakeReservationAction alloc] initWithUrl:ACTION_URL(RESERVATION_URL) service:WebServiceMakeReservation param:postCardParam];
    
    return action;
}

#pragma mark - Manage Answer

- (void)handleDownloadedData:(NSDictionary *)obj
{
    [super handleDownloadedData:obj];
    
    NSHTTPURLResponse *header = [obj objectForKey:RESPONSE_HEADER];
    NSDictionary *body = [obj objectForKey:RESPONSE_BODY];
    [NOTIFICATION_CENTER postNotificationName:didReservationNotification object:@(header.statusCode)];
}

@end
